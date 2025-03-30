# 1. WordPress Overview 📚

### **WordPress Core** 🌐
WordPress is a popular content management system (CMS) that allows you to create and manage websites.
- Runs on PHP and requires a web server (like Nginx or Apache)
- Uses MySQL/MariaDB as its database backend
- Typically runs on port **80** (HTTP) or **443** (HTTPS)

### **WordPress Components** 💻
- **Core Files**: The main WordPress software
- **Themes**: Control site appearance
- **Plugins**: Add functionality
- **wp-config.php**: Main configuration file

---

# 2. Installing WordPress

### On **Debian/Ubuntu** 🐧

1. **Install PHP and required extensions on Alpine**:
   ```bash
   apk update && apk add --no-cache \
       php php83 php83-fpm php83-mysqli \
       php83-mbstring php83-gd php83-opcache \
       php83-phar php83-xml mariadb-client
   ```

2. **Install WP-CLI**:
   ```bash
   # Download WP-CLI PHAR file
   wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
   
   # Make it executable and move to PATH
   chmod +x wp-cli.phar
   mv wp-cli.phar /usr/local/bin/wp
   ```

3. **Download and Install WordPress using WP-CLI**:
   ```bash
   # Create WordPress directory
   mkdir -p /var/www/html/wordpress
   cd /var/www/html/wordpress
   
   # Download WordPress core
   wp --allow-root core download --force
   
   # Setup wp-config.php
   mv wp-config-sample.php wp-config.php
   chmod 777 -R /var/www/html/wordpress
   ```

---

# 3. WordPress Configuration ⚙️

### **wp-config.php Setup** 🔧

The main configuration file needs these essential settings:

```php
// Database settings
define('DB_NAME', 'wordpress');
define('DB_USER', 'wp_user');
define('DB_PASSWORD', 'your_password');
define('DB_HOST', 'localhost');

```

### **File Permissions** 📁

Proper permissions are crucial for security:

```bash
# Set ownership
chown -R www-data:www-data /var/www/wordpress

# Set directory permissions
find /var/www/wordpress -type d -exec chmod 755 {} \;

# Set file permissions
find /var/www/wordpress -type f -exec chmod 644 {} \;
```

---

## Key Takeaways 📌

- WordPress requires PHP-FPM for optimal performance with Nginx
- Always keep WordPress core, themes, and plugins updated
- Regular backups of both files and database are essential
- Proper file permissions are crucial for security
