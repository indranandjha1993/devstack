.PHONY: help up down list status restart logs clean init

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Default target
help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║          DevStack - Local Infrastructure Manager           ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)📦 Available Stacks:$(NC)"
	@echo "  • postgres   (Port 5432)  - PostgreSQL 15-alpine"
	@echo "  • mysql      (Port 3306)  - MySQL 8.0-alpine"
	@echo "  • mongodb    (Port 27017) - MongoDB 7.0"
	@echo "  • redis      (Port 6379)  - Redis 7-alpine"
	@echo "  • minio      (Port 9000)  - MinIO S3-compatible storage"
	@echo ""
	@echo "$(YELLOW)🚀 Usage:$(NC)"
	@echo "  $(GREEN)make up-<stack>$(NC)      Start a service (e.g., make up-postgres)"
	@echo "  $(GREEN)make down-<stack>$(NC)    Stop a service (e.g., make down-postgres)"
	@echo "  $(GREEN)make status-<stack>$(NC)  Check service status (e.g., make status-postgres)"
	@echo "  $(GREEN)make logs-<stack>$(NC)    View service logs (e.g., make logs-postgres)"
	@echo "  $(GREEN)make list$(NC)            List all available stacks"
	@echo "  $(GREEN)make up-all$(NC)          Start all services"
	@echo "  $(GREEN)make down-all$(NC)        Stop all services"
	@echo "  $(GREEN)make status$(NC)          Show status of all services"
	@echo "  $(GREEN)make logs$(NC)            View logs from all services"
	@echo "  $(GREEN)make clean$(NC)           Remove all volumes and containers"
	@echo "  $(GREEN)make restart-<stack>$(NC) Restart a service"
	@echo ""
	@echo "$(YELLOW)ℹ️  Examples:$(NC)"
	@echo "  Start PostgreSQL:"
	@echo "    $$ make up-postgres"
	@echo ""
	@echo "  Start Redis and MySQL:"
	@echo "    $$ make up-redis up-mysql"
	@echo ""
	@echo "  View PostgreSQL logs:"
	@echo "    $$ make logs-postgres"
	@echo ""
	@echo "  Stop all services:"
	@echo "    $$ make down-all"
	@echo ""

# List available stacks
list:
	@echo "$(GREEN)✓ Available stacks:$(NC)"
	@echo ""
	@docker-compose config --services

# === PostgreSQL ===
up-postgres:
	@echo "$(BLUE)Starting PostgreSQL...$(NC)"
	@docker-compose up -d postgres
	@echo "$(GREEN)✓ PostgreSQL started$(NC)"
	@echo ""
	@echo "$(YELLOW)Connection Info:$(NC)"
	@echo "  Host:     localhost"
	@echo "  Port:     5432"
	@echo "  Database: devstack"
	@echo "  User:     postgres"
	@echo "  Password: postgres"
	@echo ""
	@echo "$(YELLOW)Connection String:$(NC)"
	@echo "  postgresql://postgres:postgres@localhost:5432/devstack"
	@echo ""

down-postgres:
	@echo "$(BLUE)Stopping PostgreSQL...$(NC)"
	@docker-compose stop postgres
	@echo "$(GREEN)✓ PostgreSQL stopped$(NC)"

status-postgres:
	@echo "$(BLUE)PostgreSQL Status:$(NC)"
	@docker-compose ps postgres || echo "$(RED)PostgreSQL is not running$(NC)"

logs-postgres:
	@docker-compose logs -f postgres

restart-postgres: down-postgres up-postgres

# === MySQL ===
up-mysql:
	@echo "$(BLUE)Starting MySQL...$(NC)"
	@docker-compose up -d mysql
	@echo "$(GREEN)✓ MySQL started$(NC)"
	@echo ""
	@echo "$(YELLOW)Connection Info:$(NC)"
	@echo "  Host:     localhost"
	@echo "  Port:     3306"
	@echo "  Database: devstack"
	@echo "  User:     devstack"
	@echo "  Password: devstack"
	@echo "  Root:     root / root"
	@echo ""
	@echo "$(YELLOW)Connection String:$(NC)"
	@echo "  mysql://devstack:devstack@localhost:3306/devstack"
	@echo ""

down-mysql:
	@echo "$(BLUE)Stopping MySQL...$(NC)"
	@docker-compose stop mysql
	@echo "$(GREEN)✓ MySQL stopped$(NC)"

status-mysql:
	@echo "$(BLUE)MySQL Status:$(NC)"
	@docker-compose ps mysql || echo "$(RED)MySQL is not running$(NC)"

logs-mysql:
	@docker-compose logs -f mysql

restart-mysql: down-mysql up-mysql

# === MongoDB ===
up-mongodb:
	@echo "$(BLUE)Starting MongoDB...$(NC)"
	@docker-compose up -d mongodb
	@echo "$(GREEN)✓ MongoDB started$(NC)"
	@echo ""
	@echo "$(YELLOW)Connection Info:$(NC)"
	@echo "  Host:     localhost"
	@echo "  Port:     27017"
	@echo "  Database: devstack"
	@echo "  User:     root"
	@echo "  Password: root"
	@echo ""
	@echo "$(YELLOW)Connection String:$(NC)"
	@echo "  mongodb://root:root@localhost:27017/devstack"
	@echo ""

down-mongodb:
	@echo "$(BLUE)Stopping MongoDB...$(NC)"
	@docker-compose stop mongodb
	@echo "$(GREEN)✓ MongoDB stopped$(NC)"

status-mongodb:
	@echo "$(BLUE)MongoDB Status:$(NC)"
	@docker-compose ps mongodb || echo "$(RED)MongoDB is not running$(NC)"

logs-mongodb:
	@docker-compose logs -f mongodb

restart-mongodb: down-mongodb up-mongodb

# === Redis ===
up-redis:
	@echo "$(BLUE)Starting Redis...$(NC)"
	@docker-compose up -d redis
	@echo "$(GREEN)✓ Redis started$(NC)"
	@echo ""
	@echo "$(YELLOW)Connection Info:$(NC)"
	@echo "  Host:     localhost"
	@echo "  Port:     6379"
	@echo "  Database: 0"
	@echo ""
	@echo "$(YELLOW)Connection String:$(NC)"
	@echo "  redis://localhost:6379"
	@echo ""

down-redis:
	@echo "$(BLUE)Stopping Redis...$(NC)"
	@docker-compose stop redis
	@echo "$(GREEN)✓ Redis stopped$(NC)"

status-redis:
	@echo "$(BLUE)Redis Status:$(NC)"
	@docker-compose ps redis || echo "$(RED)Redis is not running$(NC)"

logs-redis:
	@docker-compose logs -f redis

restart-redis: down-redis up-redis

# === MinIO ===
up-minio:
	@echo "$(BLUE)Starting MinIO...$(NC)"
	@docker-compose up -d minio
	@echo "$(GREEN)✓ MinIO started$(NC)"
	@echo ""
	@echo "$(YELLOW)Connection Info:$(NC)"
	@echo "  S3 API:     http://localhost:9000"
	@echo "  Console:    http://localhost:9001"
	@echo "  Root User:  devstack"
	@echo "  Password:   devstackpassword"
	@echo ""
	@echo "$(YELLOW)AWS CLI Configuration:$(NC)"
	@echo "  aws configure --profile devstack"
	@echo "  Access Key: devstack"
	@echo "  Secret Key: devstackpassword"
	@echo "  Region:     us-east-1"
	@echo "  Endpoint:   http://localhost:9000"
	@echo ""

down-minio:
	@echo "$(BLUE)Stopping MinIO...$(NC)"
	@docker-compose stop minio
	@echo "$(GREEN)✓ MinIO stopped$(NC)"

status-minio:
	@echo "$(BLUE)MinIO Status:$(NC)"
	@docker-compose ps minio || echo "$(RED)MinIO is not running$(NC)"

logs-minio:
	@docker-compose logs -f minio

restart-minio: down-minio up-minio

# === Bulk Operations ===
up-all:
	@echo "$(BLUE)Starting all services...$(NC)"
	@docker-compose up -d
	@echo "$(GREEN)✓ All services started$(NC)"
	@echo ""
	@make status

down-all:
	@echo "$(BLUE)Stopping all services...$(NC)"
	@docker-compose down
	@echo "$(GREEN)✓ All services stopped$(NC)"

status:
	@echo "$(BLUE)Service Status:$(NC)"
	@echo ""
	@docker-compose ps

logs:
	@docker-compose logs -f

restart:
	@echo "$(BLUE)Restarting all services...$(NC)"
	@docker-compose restart
	@echo "$(GREEN)✓ All services restarted$(NC)"

# === Cleanup ===
clean:
	@echo "$(RED)⚠️  WARNING: This will remove all containers and volumes$(NC)"
	@echo "$(RED)All data will be permanently deleted$(NC)"
	@read -p "Are you sure? (y/N) " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "$(BLUE)Cleaning up...$(NC)"; \
		docker-compose down -v; \
		echo "$(GREEN)✓ Cleanup complete$(NC)"; \
	else \
		echo "$(YELLOW)Cancelled$(NC)"; \
	fi

# === Utility ===
version:
	@echo "DevStack v0.1.0"

prune:
	@echo "$(BLUE)Pruning unused Docker resources...$(NC)"
	@docker system prune -f
	@echo "$(GREEN)✓ Cleanup complete$(NC)"
