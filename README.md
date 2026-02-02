# DevStack — Local Infrastructure Made Stupidly Simple

DevStack is a dead-simple way to manage local development infrastructure using Docker Compose and Make.

**No YAML writing. No configuration files. Just `make up-postgres` and go.**

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose installed
- `make` command available
- Terminal/shell access

### 30-Second Setup

```bash
# Start PostgreSQL
make up-postgres

# Start Redis
make up-redis

# View all running services
make status

# Stop everything
make down-all
```

That's it. Your services are running with persistent data.

## 📦 Available Stacks

| Stack | Image | Port | Purpose |
|-------|-------|------|---------|
| **postgres** | postgres:15-alpine | 5432 | Relational database |
| **mysql** | mysql:8.0-alpine | 3306 | MySQL database |
| **mongodb** | mongo:7.0 | 27017 | NoSQL document database |
| **redis** | redis:7-alpine | 6379 | In-memory cache/store |
| **minio** | minio/latest | 9000/9001 | S3-compatible object storage |

All services:
- ✅ Persist data across restarts (in Docker volumes)
- ✅ Include health checks
- ✅ Use standard ports
- ✅ Have sensible local dev credentials

## 📖 Commands

### Start/Stop Individual Services

```bash
# Start a single service
make up-postgres
make up-redis

# Stop a single service
make down-postgres
make down-redis

# Restart a service
make restart-postgres

# View logs
make logs-postgres
```

### View Status & Logs

```bash
# Show status of all services
make status

# Check individual service status
make status-postgres
make status-redis

# View logs from all services (follow mode)
make logs

# View logs from a specific service
make logs-mysql
```

### Bulk Operations

```bash
# Start everything
make up-all

# Stop everything
make down-all

# Restart everything
make restart

# Clean help (lists all available commands with colors)
make help
```

### Advanced

```bash
# List available stacks
make list

# Clean up volumes and containers (DESTRUCTIVE)
make clean

# Prune unused Docker resources
make prune
```

## 🔌 Connection Details

When you start a service, the Makefile prints connection details. Here are the defaults:

### PostgreSQL
```
Host:     localhost
Port:     5432
Database: devstack
User:     postgres
Password: postgres

Connection String:
postgresql://postgres:postgres@localhost:5432/devstack
```

### MySQL
```
Host:     localhost
Port:     3306
Database: devstack
User:     devstack
Password: devstack
Root:     root / root

Connection String:
mysql://devstack:devstack@localhost:3306/devstack
```

### MongoDB
```
Host:     localhost
Port:     27017
Database: devstack
User:     root
Password: root

Connection String:
mongodb://root:root@localhost:27017/devstack
```

### Redis
```
Host:     localhost
Port:     6379
Database: 0

Connection String:
redis://localhost:6379
```

### MinIO
```
S3 API:   http://localhost:9000
Console:  http://localhost:9001
User:     devstack
Password: devstackpassword
```

## 💾 Data Persistence

All services persist data in Docker volumes:

```
devstack_postgres_data   # PostgreSQL data
devstack_mysql_data      # MySQL data
devstack_mongodb_data    # MongoDB data
devstack_redis_data      # Redis persistence
devstack_minio_data      # MinIO storage
```

**Your data survives:**
- ✅ Service restarts
- ✅ System reboots
- ❌ `make clean` (removes volumes)

Data is only deleted when you explicitly run `make clean`.

## 🔍 Common Workflows

### Start PostgreSQL and Redis
```bash
make up-postgres
make up-redis
make status
```

### Check why a service isn't starting
```bash
make logs-postgres
```

### Replace an entire stack (clear data)
```bash
make down-postgres
make clean  # Warning: removes all data
make up-postgres
```

### Connect from your app
Use the connection strings printed by `make up-*` commands or reference the table above.

**Example (Node.js with pg):**
```javascript
const { Client } = require('pg');

const client = new Client({
  connectionString: 'postgresql://postgres:postgres@localhost:5432/devstack'
});

await client.connect();
```

## 🛠️ Troubleshooting

### Port already in use
```bash
# Find what's using port 5432
lsof -i :5432

# Change the port in docker-compose.yml
# Change "5432:5432" to "15432:5432"
```

### Service won't start
```bash
# Check logs
make logs-postgres

# Verify Docker is running
docker ps

# Restart Docker and try again
make down-all
make up-all
```

### Need to access a service container
```bash
# PostgreSQL shell
docker exec -it devstack_postgres psql -U postgres

# MongoDB shell
docker exec -it devstack_mongodb mongosh

# Redis CLI
docker exec -it devstack_redis redis-cli
```

## 📝 Notes

- Services automatically create a `devstack` database/namespace on first run
- Default credentials are designed for **local development only**
- All services run on the same Docker network (`devstack`)
- Health checks ensure services are ready before use

## 🚀 Next Steps

See [docker-compose.yml](docker-compose.yml) for detailed service configurations.

---

**DevStack v0.1.0** — Made with ❤️ for local development
