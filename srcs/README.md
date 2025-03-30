# Inception Project Overview 🌐

This project implements a small but complete web infrastructure using Docker containers. It consists of three main services working together to serve a WordPress website.

## Services Architecture 💻

### 1. Nginx 🔒
- Acts as reverse proxy and web server
- Handles SSL/TLS termination
- Serves on port 443 (HTTPS)
- Forwards PHP requests to WordPress

### 2. WordPress + PHP-FPM 📝
- WordPress core files
- PHP-FPM process manager
- Runs on port 9000
- Processes PHP files

### 3. MariaDB 💾
- Database server
- Stores WordPress data
- Runs on port 3306
- Secured with custom credentials

## Project Structure 📚

```plaintext
Inception/                   # Root directory
├── Makefile                # Build and management commands
├── secrets/                # Sensitive data (Docker secrets)
│   ├── README.md
│   ├── credentials.txt      # WordPress user credentials
│   ├── db_password.txt      # Database user password
│   └── db_root_password.txt # Database root password
├── srcs/                   # Main source directory
    ├── docker-compose.yml    # Container orchestration
    ├── .env                  # Environment variables
    └── requirements/         # Service configurations
        ├── nginx/
        │   ├── Dockerfile      # Nginx image build
        │   ├── conf/
        │   │   └── nginx.conf  # Nginx configuration
        │   └── tools/
        │       └── entrypoint.sh # Nginx startup script
        ├── wordpress/
        │   ├── Dockerfile      # WordPress image build
        │   ├── conf/
        │   │   └── www.conf   # PHP-FPM configuration
        │   └── tools/
        │       ├── entrypoint.sh # WordPress setup
        │       └── wp-cli.phar  # WordPress CLI tool
        └── mariadb/
            ├── Dockerfile      # MariaDB image build
            ├── conf/
            │   └── mariadb-server.cnf # DB configuration
            └── tools/
                └── entrypoint.sh # Database initialization
```

## Key Features ✨

1. **Containerization**
   - Each service in its own container
   - No direct container linking
   - Uses Docker networks for isolation

2. **Security**
   - TLS/SSL encryption
   - Docker secrets for credentials
   - No password in environment variables

3. **Persistence**
   - Volume mapping for WordPress files
   - Database persistence across restarts
   - Configuration preserved in volumes

4. **Health Checks**
   - Each service monitored
   - Automatic restart on failure
   - Dependencies properly managed

## Network Flow 🖇

```plaintext
Client → HTTPS:443 → Nginx → WordPress:9000 → MariaDB:3306
```

## Volume Structure 📂

```plaintext
~/data/
├── wordpress/    # WordPress files
└── mariadb/      # Database files
```

## Environment Files 🔑

### `.env` File
Normally, the `.env` file should **never** be committed to version control. However, for this learning project, we include:
- `.env` - The actual environment file
- `.env.example` - A template showing required variables
---

## 🌟 Final Notes

This project demonstrates:
- Docker containerization
- Service orchestration
- Secure credential management
- High availability configuration

Remember that while some sensitive files are included here for learning purposes, in a production environment:
- Never commit `.env` files
- Never commit secrets
- Use proper secret management
- Implement secure credential rotation

---

Happy coding! 🚀

