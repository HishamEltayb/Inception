# 42 Inception Project 

![42 Logo](path_to_42_logo.png)

## 🎯 Description

System administration and containerization project at **42** focusing on **Docker**, **bash scripting**, and **Linux systems**. Build isolated environments using Docker Compose.

## ⚡ Features

* 🐳 Docker environment setup
* 🔄 Multi-container orchestration
* 📝 Automated configuration scripts
* 🌐 Nginx, MySQL, WordPress integration
* 🔌 Container networking
* 🚀 Easy deployment system

## 🛠 Tech Stack

* `Docker` - Containerization
* `Docker Compose` - Container orchestration
* `Bash` - Automation
* `Nginx` - Web server
* `MySQL` - Database
* `WordPress` - CMS

## 📦 Installation

1. **Clone repo:**
   ```bash
   git clone https://github.com/HishamEltayb/Inception.git
   cd inception
   ```

2. **Build containers:**
   ```bash
   docker-compose build
   ```

3. **Launch services:**
   ```bash
   docker-compose up -d
   ```

4. **Access points:**
   | Service    | URL                    |
   |------------|------------------------|
   | Nginx      | `http://localhost`     |
   | WordPress  | `http://localhost:8080`|
   | MySQL      | `localhost:3306`       |

## ✨ Usage

- [ ] Access WordPress dashboard
- [ ] Configure Nginx settings
- [ ] Manage MySQL database

## 🔍 Troubleshooting

**Check Docker:**
```bash
docker --version
docker-compose --version
```

**View logs:**
```bash
docker-compose logs
```

## ⚠️ Requirements

- [x] Docker
- [x] Docker Compose
- [ ] Compatible OS (Linux/macOS)

## 📄 License

[MIT](LICENSE)

## 👤 Author

**[Your Name]**
* 42 Student
* GitHub: [@yourusername](https://github.com/yourusername)

---
*Made with ❤️ at 42*
