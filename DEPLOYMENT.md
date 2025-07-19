# VimGenius Deployment Guide

## Overview
VimGenius is now updated to Ruby 3.3.8 and Rails 7.1.5 and ready for deployment to your Proxmox server.

## Pre-deployment Setup

### 1. Repository Setup
You need to set up your own repository for deployment:

```bash
# Option A: Create a new repository on GitHub, then:
git remote remove origin
git remote add origin https://github.com/julroger2013/vimgenius.git

# Option B: Fork the original repository on GitHub, then:
git remote set-url origin https://github.com/julroger2013/vimgenius.git
```

### 2. Commit and Push Changes
```bash
git add .
git commit -m "Modernize VimGenius: Update to Ruby 3.3.8, Rails 7.1.5, and add Docker deployment"
git push origin master
```

## Server Setup

### 1. Prepare Proxmox Container
SSH to your Proxmox server and set up the container:

```bash
ssh root@192.168.50.10

# Create application directory in container 110
pct exec 110 -- mkdir -p /opt/vimgenius

# Install required packages
pct exec 110 -- apt-get update
pct exec 110 -- apt-get install -y git docker.io docker-compose sshpass

# Clone your repository
pct exec 110 -- git clone https://github.com/julroger2013/vimgenius.git /opt/vimgenius
```

### 2. Configure Environment
```bash
# SSH into the container and set up environment
pct exec 110 -- bash -c 'cd /opt/vimgenius && cp docker-compose.yml docker-compose.production.yml'

# Update production configuration if needed
```

## Deployment

### 1. Local Deployment
Run the deployment script from your local machine:

```bash
cd /Users/mrogers/Documents/vimgenius
./deploy.sh
```

### 2. Manual Deployment (if script fails)
```bash
ssh root@192.168.50.10
pct exec 110 -- bash -c 'cd /opt/vimgenius && git pull origin master'
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose down'
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose build --no-cache'
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose up -d'
```

## Access
- **Production URL**: http://192.168.50.254:3000
- **Local Development**: http://localhost:3000

## Troubleshooting

### Check Application Status
```bash
ssh root@192.168.50.10
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose ps'
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose logs web'
```

### Reset Database
```bash
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose exec web rails db:reset'
```

### View Application Logs
```bash
pct exec 110 -- bash -c 'cd /opt/vimgenius && docker compose logs -f web'
```

## Files Created/Modified for Deployment

### New Files
- `Dockerfile` - Container definition
- `docker-compose.yml` - Multi-container orchestration
- `deploy.sh` - Automated deployment script
- `.dockerignore` - Docker build exclusions
- `app/assets/config/manifest.js` - Rails 7 asset manifest
- `config/storage.yml` - Active Storage configuration

### Modified Files
- `config/environments/production.rb` - Updated for Docker deployment
- `config/database.yml` - Added production database configuration
- All migration files - Updated with Rails version specifications

## Technology Stack
- **Ruby**: 3.3.8
- **Rails**: 7.1.5
- **Database**: PostgreSQL 15
- **Web Server**: Puma 6.x
- **Container**: Docker with Docker Compose
- **Server**: Proxmox LXC Container

## Next Steps
1. Set up your GitHub repository
2. Push the modernized code
3. Run the deployment script
4. Access your application at http://192.168.50.254:3000