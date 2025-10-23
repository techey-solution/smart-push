# 🚀 Smart Push - Quick Installation Guide

## One-Line Installation

**Universal (Auto-detects OS):**
```bash
curl -s https://raw.githubusercontent.com/techey-solution/smart-push/main/install.sh | bash
```

## Direct Installation Commands

**macOS:**
```bash
brew install smart-push
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt install smart-push
```

## Usage

```bash
# Interactive mode (smart suggestions)
smart-push

# With custom commit message
smart-push "Fix user login bug"

# With custom commit message and branch
smart-push "Add new feature" feature-branch
```

## Features

- 🧠 Smart commit message suggestions
- 🔍 Automatic project type detection
- ✅ Pre-commit checks
- 🎨 Interactive workflow with colored output
- 🖥️ Cross-platform support (macOS & Linux)

## Repository

https://github.com/techey-solution/smart-push

---

**Note:** The installer will automatically try direct installation first, then fall back to alternative methods if needed.
