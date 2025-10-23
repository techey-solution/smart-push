# 🚀 Smart Push CLI Package

A complete CLI package for the Smart Push tool that automates Git workflows with intelligent commit message suggestions.

## 📁 Project Structure

```
smart-push-package/
├── smart-push              # Main CLI script (executable)
├── install.sh              # Universal installer script
├── homebrew/
│   └── smart-push.rb       # Homebrew Formula
└── debian/
    ├── control             # Debian package metadata
    ├── install             # File mapping for Debian package
    └── changelog           # Debian changelog
```

## 🛠️ Setup Instructions

### 1. Customize Configuration

Before using these files, you need to customize the following placeholders:

#### In `homebrew/smart-push.rb`:
- `yourorg` → Your GitHub organization/username
- `your_sha256_hash_here` → Actual SHA256 of your release tarball
- License type (currently set to MIT)

#### In `debian/control`:
- `Your Name <your.email@example.com>` → Your contact details
- `https://github.com/yourorg/smart-push` → Your GitHub repository URL

#### In `debian/changelog`:
- `Your Name <your.email@example.com>` → Your contact details
- `Mon, 01 Jan 2024 12:00:00 +0000` → Actual release date

#### In `install.sh`:
- `yourorg` → Your GitHub organization/username
- `smart-push` → Your repository name (if different)
- `1.0.0` → Your release version
- Update `DEB_PACKAGE_URL` if your package URL structure is different

### 2. GitHub Repository Setup

1. Create a GitHub repository for your project
2. Upload all files to the repository
3. Create a release with version tag (e.g., `v1.0.0`)
4. Upload the `.deb` package to the release

### 3. Homebrew Tap Setup

1. Create a Homebrew tap repository: `yourorg/homebrew-tap`
2. Add the `smart-push.rb` formula to the tap
3. Update the installer script to use your tap

## 📦 Installation Methods

### Universal Installer (Recommended)
```bash
curl -s https://raw.githubusercontent.com/techey-solution/smart-push/main/install.sh | bash
```

**Supported Platforms:**
- ✅ macOS (Intel & Apple Silicon)
- ✅ Linux (Ubuntu, Debian, CentOS, Arch, etc.)
- ✅ Windows (via WSL or Git Bash)
- ✅ Any system with curl/wget

### Direct Installation

**macOS (Homebrew):**
```bash
brew install smart-push
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt install smart-push
```

### Windows Installation

**Option 1: WSL (Recommended)**
```bash
# Install WSL
wsl --install

# Open WSL terminal and run
curl -s https://raw.githubusercontent.com/techey-solution/smart-push/main/install.sh | bash
```

**Option 2: Git Bash**
```bash
# Install Git for Windows, then open Git Bash and run
curl -s https://raw.githubusercontent.com/techey-solution/smart-push/main/install.sh | bash
```

**Option 3: Manual Installation**
```bash
# Download script
curl -O https://raw.githubusercontent.com/techey-solution/smart-push/main/smart-push

# Make executable
chmod +x smart-push

# Add to PATH
mv smart-push /usr/local/bin/
```

### Alternative Installation Methods

**macOS (Homebrew Tap):**
```bash
brew tap techey-solution/smart-push
brew install techey-solution/smart-push/smart-push
```

**Debian/Ubuntu (Manual):**
```bash
# Download and install .deb package
wget https://github.com/techey-solution/smart-push/releases/download/v1.0.0/smart-push_1.0.0_all.deb
sudo dpkg -i smart-push_1.0.0_all.deb
```

### Manual Installation
```bash
# Download script
curl -O https://raw.githubusercontent.com/techey-solution/smart-push/main/smart-push

# Make executable
chmod +x smart-push

# Install to PATH
sudo mv smart-push /usr/local/bin/
```

## 🔨 Building Debian Package

To build the Debian package:

```bash
# From the project root
dpkg-deb --build debian smart-push_1.0.0_all.deb
```

## 🚀 Usage

```bash
# Interactive mode (smart suggestions)
smart-push

# With custom commit message
smart-push "Fix user login bug"

# With custom commit message and branch
smart-push "Add new feature" feature-branch
```

## ✨ Features

- **Smart Commit Messages**: Analyzes file changes and suggests appropriate commit messages
- **Project Detection**: Automatically detects frontend/backend projects
- **Pre-commit Checks**: Validates code for common issues before committing
- **Interactive Workflow**: Colored output with step-by-step guidance
- **Cross-platform**: Works on macOS and Linux
- **Package Management**: Available via Homebrew and Debian packages

## 🔧 Dependencies

- Git (required for Git operations)
- Bash (for script execution)
- Sort command (for file sorting operations)
- curl or wget (for installer)

## 📝 License

MIT License - customize as needed in the Homebrew formula and Debian control file.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the installation process
5. Submit a pull request

## 📞 Support

For issues and questions, please open an issue on the GitHub repository.

---

**Note**: Remember to replace all placeholder values (`yourorg`, `your.email@example.com`, etc.) with your actual information before publishing.
