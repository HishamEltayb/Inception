# 1. Nginx Overview 📚

### **Nginx Server** 🌐
Nginx is a powerful web server that can also act as a reverse proxy, load balancer, and HTTP cache.
- Serves static content directly
- Proxies dynamic content to PHP-FPM or other application servers
- Typically listens on ports **80** (HTTP) and **443** (HTTPS)

### **Key Components** 💻
- **nginx.conf**: Main configuration file
- **sites-available/**: Individual site configurations
- **sites-enabled/**: Symlinks to enabled sites
- **modules/**: Additional functionality modules

---

# 2. Installing Nginx

### On **Debian/Ubuntu** 🐧

1. **Update and install**:
   ```bash
   sudo apt update
   sudo apt install nginx
   ```

2. **Check installation**:
   ```bash
   nginx -v
   ```

### On **Alpine Linux** 🐚

1. **Install Nginx**:
   ```bash
   apk add nginx
   ```

2. **Check installation**:
   ```bash
   nginx -v
   ```

---

# 3. Nginx Configuration ⚙️

### **Complete Server Block** 🔧

```nginx
server {
    # SSL Configuration
    listen 443 ssl;
    server_name YOUR_DOMAIN;
    root /var/www/wordpress;
    index index.php index.html;

    # SSL Certificate Settings
    ssl_certificate /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;
    ssl_protocols TLSv1.2 TLSv1.3;                # Modern secure protocols only
    ssl_session_timeout 1d;                       # Session duration
    ssl_session_cache shared:SSL:50m;            # Shared cache between workers
    ssl_session_tickets off;                      # Disable TLS session tickets
    ssl_prefer_server_ciphers off;               # Let client choose ciphers

    # WordPress PHP Processing
    location / {
        try_files $uri $uri/ /index.php?$args;    # WordPress pretty URLs
    }

    location ~ \.php$ {
        # FastCGI Configuration
        fastcgi_split_path_info ^(.+\.php)(/.+)$;  # Split URL into script and path info
        fastcgi_pass wordpress:9000;              # PHP-FPM container address
        fastcgi_index index.php;                  # Default index file
        include fastcgi_params;                    # Include default FastCGI params
        
        # Script filename construction
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

### **Parameter Explanations** 📝

#### SSL Parameters
- `listen 443 ssl`: Listen on port 443 with SSL enabled
- `ssl_protocols`: Only allow secure TLS versions (1.2 and 1.3)
- `ssl_session_timeout`: How long to keep SSL sessions in cache
- `ssl_session_cache`: Shared cache between Nginx worker processes
- `ssl_session_tickets`: Disable tickets for better security
- `ssl_prefer_server_ciphers`: Modern approach letting clients choose ciphers

#### FastCGI Parameters
- `fastcgi_split_path_info`: Separates PHP script name from additional path info
- `fastcgi_pass`: Address of PHP-FPM container (using Docker service name)
- `fastcgi_index`: Default file to process if none specified
- `SCRIPT_FILENAME`: Full path to PHP script being executed

### **Generate SSL Certificate** 🔒

```bash
# Create certificates directory
mkdir -p /etc/nginx/ssl

# Generate self-signed certificate
openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/key.pem \
    -out /etc/nginx/ssl/cert.pem \
    -subj "/C=MA/ST=BN/L=BN/O=1337/OU=1337/CN=YOUR_DOMAIN"
```

#### Certificate Parameters
- `-x509`: Generate self-signed certificate
- `-nodes`: No passphrase protection
- `-days 365`: Certificate validity period
- `-newkey rsa:2048`: Generate new 2048-bit RSA key
- `-subj`: Certificate subject fields
  - `C`: Country (MA for Morocco)
  - `ST`: State/Province
  - `L`: Locality/City
  - `O`: Organization
  - `OU`: Organizational Unit
  - `CN`: Common Name (your domain)

---

# 4. Service Management 🔄

### **On Debian/Ubuntu (systemd)**

```bash
systemctl start|stop|restart|status nginx
```

### **On Alpine (OpenRC)**

```bash
rc-service nginx start|stop|restart|status
```

## Key Takeaways 📌

- Always test configuration before reloading: `nginx -t`
- Use `nginx -s reload` to reload configuration without downtime
- Keep SSL certificates up to date
- Configure proper security headers
- Regular log rotation is important
