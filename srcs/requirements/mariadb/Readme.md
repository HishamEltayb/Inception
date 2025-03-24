# 1. MariaDB Overview 📚

### **MariaDB Server** 🗄️
MariaDB **Server** is the database engine that stores, manages, and processes data. It listens for client connections, executes SQL queries, and handles data transactions.
- Runs as a background service (`mysqld`).
- Stores data in `/var/lib/mysql/`.
- Listens on port **3306** by default.

### **MariaDB Client** 💻
MariaDB **Client** is a command-line tool (`mysql`) that allows you to connect to the MariaDB Server, execute SQL queries, and manage databases.
- Runs commands like `mysql -u root -p`.
- Communicates with the server over **port 3306**.

### **Note: Difference Between MariaDB and MySQL** 🔄
MySQL and MariaDB are both open-source database technologies. Both store data in a tabular format with rows and columns, but there are some key differences:

- **MySQL** is widely adopted and is the primary relational database for many popular websites, applications, and commercial products.
- **MariaDB** is a modified version of MySQL. It was created by MySQL’s original development team due to licensing and distribution concerns after Oracle acquired MySQL. Since the acquisition, MySQL and MariaDB have evolved differently.
  
MariaDB adopts MySQL’s data and table definition files and uses identical client protocols, APIs, ports, and sockets. This compatibility ensures that MySQL users can switch to MariaDB without hassle.

---

# 2. Installing MariaDB Server and Client

### On **Debian/Ubuntu** 🐧

1. **Update the package list**:
   ```bash
   sudo apt update
   ```

2. **Install MariaDB Server**:
   ```bash
   sudo apt install mariadb-server
   ```

3. **Install MariaDB Client** (optional, for managing databases from the command line):
   ```bash
   sudo apt install mariadb-client
   ```

4. **Check the installation**:
   ```bash
   mariadb --version  # or
   mysql --version
   ```

### On **Alpine Linux** 🐚

1. **Install MariaDB Server and Client**:
   ```bash
   sudo apk add mariadb mariadb-client
   ```

2. **Check the installation**:
   ```bash
   mariadb --version  # or
   mysql --version
   ```

---

# 3. Controlling MariaDB Using System Commands ⚙️

To manage MariaDB, you need to use system commands that interact with the init system of your operating system.

### **Debian and Ubuntu (systemd-based systems)** 🔧

You can use either `systemctl` (modern) or `service` (legacy wrapper):

```bash
# Using systemctl (recommended)
systemctl start|stop|restart|status|enable|disable mariadb

# Using service (wrapper for systemctl)
service mariadb start|stop|restart|status
```

- `systemctl` is the primary tool for managing services in **systemd**.
- `service` is a compatibility wrapper for `systemctl`.
  
If systemd is missing, install it with:

```bash
sudo apt install systemd
```

### **Alpine Linux (OpenRC-based systems)** 🔨

Use `rc-service` to manage MariaDB:

```bash
rc-service mariadb start|stop|restart|status
```

Alpine Linux does **not** use **systemd**. It uses **OpenRC** instead.

To install OpenRC (if missing):

```bash
sudo apk add openrc
```

- In **Alpine**, `rc-service` is a **command provided by OpenRC** (not a wrapper), and services are managed by **OpenRC**.
- **Important Note**: OpenRC in containers may not work correctly. However, you can trick it by adding the following file:
  ```bash
  mkdir -p /run/openrc && touch /run/openrc/softlevel
  ```

## 🚀 Summary Table: OpenRC Commands

| Command | Description |
|---------|-------------|
| `rc-status` | Show running services |
| `rc-status --all` | Show all services (running & stopped) |
| `rc-service <service> start` | Start a service |
| `rc-service <service> stop` | Stop a service |
| `rc-service <service> restart` | Restart a service |
| `rc-service <service> status` | Check service status |
| `rc-update add <service> default` | Enable service at boot |
| `rc-update del <service> default` | Disable service at boot |
| `rc-update show` | Show enabled services |
| `openrc` | Initialize OpenRC (if needed) |
| `openrc default` | Switch to default runlevel |

---

## Key Takeaways 📌

- In **Debian/Ubuntu**, `service` is a **wrapper** for `systemctl`, and services are managed by **systemd**.
- In **Alpine**, `rc-service` is a **command provided by OpenRC** (not a wrapper), and services are managed by **OpenRC**.





---

> ⚠️ **WARNING**: Controlling MariaDB Without System Commands (Not Recommended) 🚨
> 
> While the recommended way to manage MariaDB is by using **system commands** (`systemctl`, `service`, or `rc-service`), you can technically **start, stop, and restart MariaDB manually** using direct commands.
> 
> ### ✅ Direct Commands to Control MariaDB
> 
> Instead of using `systemctl` or `rc-service`, you can run MariaDB directly from the command line:
> 
> #### Start MariaDB Server Manually
> ```bash
> mysqld --user=mysql --datadir=/var/lib/mysql
> ```
> This starts the MariaDB server **without system service management**.
> 
> #### Stop MariaDB Manually
> ```bash
> mysqladmin -u root -p shutdown
> ```
> This stops the running MariaDB server if you're logged in as root.
> 
> #### Restart MariaDB Manually
> You would need to **stop** the process using the shutdown command or manually kill it:
> ```bash
> pkill -f mysqld
> ```
> Then restart it using `mysqld`.
> 
> ### ❌ Why This is NOT Recommended
> 
> Manually controlling MariaDB **bypasses system service management**, leading to several issues:
> 
> 1️⃣ **No Automatic Startup** – MariaDB **won't start automatically** when the system boots unless you configure it manually.  
> 2️⃣ **No Dependency Management** – Other services that depend on MariaDB (e.g., web servers) **may fail** if the database is not started properly.  
> 3️⃣ **Risk of Data Loss** – Improper shutdowns (e.g., using `pkill`) can **corrupt data** and cause database inconsistencies.  
> 4️⃣ **No Service Monitoring** – You **won't be able to check the status** using `systemctl status mariadb` or `rc-service mariadb status`, making debugging harder.  
> 5️⃣ **Security Risks** – Running MariaDB manually may lead to **misconfigured permissions**, making it more vulnerable to attacks.  
> 
> ### ✅ Recommended Approach: Use System Commands
> 
> #### For Debian/Ubuntu (systemd)
> ```bash
> systemctl start|stop|restart|status mariadb
> ```
> 
> #### For Alpine Linux (OpenRC)
> ```bash
> rc-service mariadb start|stop|restart|status
> ```
> 
> These commands ensure **proper service management, logging, security, and stability**.

---

# 4. MariaDB Setup on Alpine

For setting up MariaDB on Alpine Linux, you can use the following commands:

- **OpenRC Specific**: `rc-service mariadb setup`
- **General Approach**: `mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql`

These commands help initialize the MariaDB database structure, tailored for Alpine's OpenRC or a more general method suitable for various environments.


# 5. Connecting to MariaDB in alpine

To connect to mariadb server use mariadb client cli:
```bash
mysql
```
or 
```bash
mariadb
```

after connecting to mariadb server you can use sql commands to manage your database.

## SQL Query Cheat Sheet

### Database Management
| Query | Description |
|-------|------------|
| `SHOW DATABASES;` | Lists all databases on the server. |
| `CREATE DATABASE db_name;` | Creates a new database. |
| `DROP DATABASE db_name;` | Deletes a database. |
| `USE db_name;` | Switches to a specific database. |

### Table Management
| Query | Description |
|-------|------------|
| `SHOW TABLES;` | Lists all tables in the current database. |
| `CREATE TABLE table_name (id INT, name VARCHAR(100));` | Creates a new table. |
| `DESC table_name;` or `SHOW COLUMNS FROM table_name;` | Shows table structure (column details). |
| `DROP TABLE table_name;` | Deletes a table. |
| `ALTER TABLE table_name ADD column_name INT;` | Adds a new column to an existing table. |
| `ALTER TABLE table_name DROP COLUMN column_name;` | Removes a column from a table. |

### Data Manipulation (CRUD)
| Query | Description |
|-------|------------|
| `INSERT INTO table_name (col1, col2) VALUES ('value1', 'value2');` | Adds a new record to the table. |
| `SELECT * FROM table_name;` | Retrieves all records from a table. |
| `SELECT col1, col2 FROM table_name;` | Retrieves specific columns from a table. |
| `UPDATE table_name SET col1='new_value' WHERE id=1;` | Updates records in a table. |
| `DELETE FROM table_name WHERE id=1;` | Deletes a record from a table. |

### Filtering & Sorting
| Query | Description |
|-------|------------|
| `SELECT * FROM table_name WHERE col1='value';` | Retrieves records with a specific condition. |
| `SELECT * FROM table_name ORDER BY col1 ASC;` | Sorts results in ascending order. |
| `SELECT * FROM table_name ORDER BY col1 DESC;` | Sorts results in descending order. |

### Aggregation & Grouping
| Query | Description |
|-------|------------|
| `SELECT COUNT(*) FROM table_name;` | Counts the total number of records. |
| `SELECT SUM(col1) FROM table_name;` | Computes the sum of a column. |
| `SELECT AVG(col1) FROM table_name;` | Calculates the average value. |
| `SELECT col1, COUNT(*) FROM table_name GROUP BY col1;` | Groups and counts occurrences. |

### Joins (Combining Tables)
| Query | Description |
|-------|------------|
| `SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.id;` | Retrieves records that match in both tables. |
| `SELECT * FROM table1 LEFT JOIN table2 ON table1.id = table2.id;` | Retrieves all records from the left table, with matching records from the right table. |
| `SELECT * FROM table1 RIGHT JOIN table2 ON table1.id = table2.id;` | Retrieves all records from the right table, with matching records from the left table. |

### Indexes & Performance
| Query | Description |
|-------|------------|
| `CREATE INDEX idx_name ON table_name (col1);` | Creates an index to speed up searches. |
| `DROP INDEX idx_name ON table_name;` | Deletes an index. |

### User & Permissions
| Query | Description |
|-------|------------|
| `CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';` | Creates a new database user. |
| `GRANT ALL PRIVILEGES ON db_name.* TO 'username'@'localhost';` | Grants all privileges to a user. |
| `REVOKE ALL PRIVILEGES ON db_name.* FROM 'username'@'localhost';` | Revokes privileges from a user. |
| `SHOW GRANTS FOR 'username'@'localhost';` | Shows the privileges of a user. |

### Backup & Restore
| Query | Description |
|-------|------------|
| `mysqldump -u root -p db_name > backup.sql` | Exports a database to a file. |
| `mysql -u root -p db_name < backup.sql` | Imports a database from a backup file. |

---

📌 **Pro Tip:** Use `;` at the end of each query to execute it properly in MySQL/MariaDB.  


or if you want to execute commands from outside mariadb server use:
```bash
mysql -u root -p -e "<command>"
```   

