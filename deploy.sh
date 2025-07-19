#!/bin/bash

# VimGenius Deployment Script
# Deploy VimGenius Rails app to Proxmox server

set -e  # Exit on any error

echo "🚀 Starting VimGenius deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Server configuration
PROXMOX_HOST="192.168.50.10"
CONTAINER_ID="110"
APP_DIR="/opt/vimgenius"
SERVER_PASSWORD="Stanford123wannabe!"

echo -e "${YELLOW}📡 Connecting to Proxmox server...${NC}"

# Deploy to server
sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no root@$PROXMOX_HOST << EOF
echo "🔄 Setting up repository if needed..."
pct exec $CONTAINER_ID -- bash -c 'if [ ! -d $APP_DIR ]; then git clone https://github.com/julroger2013/vimgenius.git $APP_DIR; fi'

echo "🔄 Pulling latest code..."
pct exec $CONTAINER_ID -- bash -c 'cd $APP_DIR && git pull origin master'

echo "🛑 Stopping current containers..."
pct exec $CONTAINER_ID -- bash -c 'cd $APP_DIR && docker compose down'

echo "🔨 Building updated image..."
pct exec $CONTAINER_ID -- bash -c 'cd $APP_DIR && docker compose build --no-cache'

echo "🚀 Starting updated application..."
pct exec $CONTAINER_ID -- bash -c 'cd $APP_DIR && docker compose up -d'

echo "⏳ Waiting for application to start..."
sleep 10

echo "🔍 Checking application status..."
pct exec $CONTAINER_ID -- bash -c 'cd $APP_DIR && docker compose ps'
EOF

echo -e "${GREEN}✅ Deployment completed!${NC}"
echo -e "${GREEN}🌐 VimGenius should be available at: http://192.168.50.254:3000${NC}"
echo -e "${YELLOW}💡 Give it a minute to fully start up if it's not immediately available${NC}"