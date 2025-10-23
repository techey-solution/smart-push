#!/bin/bash

# 🚀 Smart Push Universal Installer
# This script detects the operating system and installs smart-push accordingly
# Usage: curl -s https://raw.githubusercontent.com/yourorg/smart-push/main/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration - CUSTOMIZE THESE VALUES
GITHUB_ORG="techey-solution"  # CUSTOMIZE: Replace with your GitHub organization/username
GITHUB_REPO="smart-push"  # CUSTOMIZE: Replace with your repository name
VERSION="1.0.0"  # CUSTOMIZE: Replace with your release version
DEB_PACKAGE_URL="https://github.com/${GITHUB_ORG}/${GITHUB_REPO}/releases/download/v${VERSION}/smart-push_${VERSION}_all.deb"  # CUSTOMIZE: Update if your deb package URL is different

# Banner
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}║   🚀 Smart Push Universal Installer  ║${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Function to detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get >/dev/null 2>&1; then
            echo "debian"
        elif command -v yum >/dev/null 2>&1; then
            echo "rhel"
        elif command -v pacman >/dev/null 2>&1; then
            echo "arch"
        else
            echo "linux"
        fi
    else
        echo "unknown"
    fi
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install on macOS
install_macos() {
    echo -e "${CYAN}🍎 Detected macOS${NC}"
    
    # Check for sort command (should be available by default on macOS)
    if ! command_exists sort; then
        echo -e "${RED}❌ sort command not found. This is unusual on macOS.${NC}"
        echo -e "${YELLOW}Please install Xcode Command Line Tools: xcode-select --install${NC}"
        exit 1
    fi
    
    if command_exists brew; then
        echo -e "${GREEN}✅ Homebrew found${NC}"
        
        # Try direct installation first
        echo -e "${YELLOW}Trying direct installation...${NC}"
        if brew install smart-push 2>/dev/null; then
            echo -e "${GREEN}✅ Smart Push installed successfully via brew!${NC}"
            return 0
        fi
        
        echo -e "${YELLOW}Direct installation not available. Installing via tap...${NC}"
        # Add the tap and install
        brew tap "${GITHUB_ORG}/${GITHUB_REPO}" || true
        brew install "${GITHUB_ORG}/${GITHUB_REPO}/smart-push"
        
        echo -e "${GREEN}✅ Smart Push installed successfully via Homebrew!${NC}"
    else
        echo -e "${YELLOW}⚠️  Homebrew not found${NC}"
        echo -e "${CYAN}Installing Homebrew first...${NC}"
        
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        # Now install smart-push
        brew tap "${GITHUB_ORG}/${GITHUB_REPO}"
        brew install "${GITHUB_ORG}/${GITHUB_REPO}/smart-push"
        
        echo -e "${GREEN}✅ Smart Push installed successfully!${NC}"
    fi
}

# Function to install on Debian/Ubuntu
install_debian() {
    echo -e "${CYAN}🐧 Detected Debian/Ubuntu${NC}"
    
    # Check if we have necessary tools
    if ! command_exists wget && ! command_exists curl; then
        echo -e "${RED}❌ Neither wget nor curl found. Please install one of them first.${NC}"
        exit 1
    fi
    
    # Check for sort command (required by smart-push)
    if ! command_exists sort; then
        echo -e "${YELLOW}⚠️  sort command not found. Installing coreutils...${NC}"
        sudo apt-get update && sudo apt-get install -y coreutils
    fi
    
    # Try direct installation first (if package is available in a PPA)
    echo -e "${YELLOW}Trying direct installation...${NC}"
    if sudo apt-get install -y smart-push 2>/dev/null; then
        echo -e "${GREEN}✅ Smart Push installed successfully via apt!${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}Direct installation not available. Downloading package...${NC}"
    
    TEMP_DIR=$(mktemp -d)
    DEB_FILE="${TEMP_DIR}/smart-push_${VERSION}_all.deb"
    
    if command_exists wget; then
        wget -O "$DEB_FILE" "$DEB_PACKAGE_URL"
    else
        curl -L -o "$DEB_FILE" "$DEB_PACKAGE_URL"
    fi
    
    if [ ! -f "$DEB_FILE" ]; then
        echo -e "${RED}❌ Failed to download package${NC}"
        echo -e "${YELLOW}You can manually download from: ${DEB_PACKAGE_URL}${NC}"
        exit 1
    fi
    
    echo -e "${YELLOW}Installing package...${NC}"
    sudo dpkg -i "$DEB_FILE" || sudo apt-get install -f -y
    
    # Clean up
    rm -rf "$TEMP_DIR"
    
    echo -e "${GREEN}✅ Smart Push installed successfully!${NC}"
}

# Function to install on other Linux distributions
install_linux_generic() {
    echo -e "${CYAN}🐧 Detected Linux (generic)${NC}"
    echo -e "${YELLOW}⚠️  Generic Linux installation not fully supported${NC}"
    echo -e "${CYAN}Please install manually:${NC}"
    echo ""
    echo -e "${BLUE}1. Download the script:${NC}"
    echo -e "   curl -O https://raw.githubusercontent.com/${GITHUB_ORG}/${GITHUB_REPO}/main/smart-push"
    echo ""
    echo -e "${BLUE}2. Make it executable:${NC}"
    echo -e "   chmod +x smart-push"
    echo ""
    echo -e "${BLUE}3. Move to PATH:${NC}"
    echo -e "   sudo mv smart-push /usr/local/bin/"
    echo ""
    echo -e "${GREEN}✅ Manual installation complete!${NC}"
}

# Function to verify installation
verify_installation() {
    echo ""
    echo -e "${YELLOW}Verifying installation...${NC}"
    
    if command_exists smart-push; then
        echo -e "${GREEN}✅ Smart Push is installed and available in PATH${NC}"
        echo -e "${CYAN}Version: $(smart-push --version 2>/dev/null || echo 'Unknown')${NC}"
    else
        echo -e "${RED}❌ Smart Push not found in PATH${NC}"
        echo -e "${YELLOW}You may need to restart your terminal or add to PATH manually${NC}"
    fi
}

# Function to show usage
show_usage() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║        🎉 Installation Complete! 🎉     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${MAGENTA}📖 Usage:${NC}"
    echo -e "  ${CYAN}smart-push [commit-message] [branch-name]${NC}"
    echo ""
    echo -e "${MAGENTA}📝 Examples:${NC}"
    echo -e "  ${CYAN}smart-push \"Fix user login bug\"${NC}"
    echo -e "  ${CYAN}smart-push \"Add new feature\" feature-branch${NC}"
    echo -e "  ${CYAN}smart-push${NC}  # Interactive mode"
    echo ""
    echo -e "${MAGENTA}🔗 Documentation:${NC}"
    echo -e "  ${CYAN}https://github.com/${GITHUB_ORG}/${GITHUB_REPO}${NC}"
    echo ""
    echo -e "${GREEN}Happy coding! 🚀${NC}"
}

# Main installation logic
main() {
    OS=$(detect_os)
    
    echo -e "${CYAN}🔍 Detected OS: ${OS}${NC}"
    echo ""
    
    case $OS in
        "macos")
            install_macos
            ;;
        "debian")
            install_debian
            ;;
        "linux"|"rhel"|"arch")
            install_linux_generic
            ;;
        *)
            echo -e "${RED}❌ Unsupported operating system: ${OSTYPE}${NC}"
            echo -e "${YELLOW}Please install manually from: https://github.com/${GITHUB_ORG}/${GITHUB_REPO}${NC}"
            exit 1
            ;;
    esac
    
    verify_installation
    show_usage
}

# Run main function
main "$@"
