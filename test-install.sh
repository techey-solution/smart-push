#!/bin/bash

# 🚀 Smart Push Test Installer for macOS
# Simple installer that definitely works

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}║   🚀 Smart Push Test Installer 🚀    ║${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

echo -e "${CYAN}🍎 Installing Smart Push for macOS${NC}"

# Download the script
echo -e "${YELLOW}📥 Downloading Smart Push...${NC}"
curl -O https://raw.githubusercontent.com/techey-solution/smart-push/main/smart-push

# Make it executable
echo -e "${YELLOW}🔧 Making executable...${NC}"
chmod +x smart-push

# Install to /usr/local/bin
echo -e "${YELLOW}📦 Installing to /usr/local/bin...${NC}"
sudo mv smart-push /usr/local/bin/

# Verify installation
echo -e "${YELLOW}✅ Verifying installation...${NC}"
if command -v smart-push >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Smart Push installed successfully!${NC}"
    echo -e "${CYAN}Version: $(smart-push --version | head -1)${NC}"
else
    echo -e "${RED}❌ Installation failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo -e "${CYAN}Usage: smart-push --help${NC}"
