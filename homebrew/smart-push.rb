# Homebrew Formula for smart-push CLI tool
# This formula installs the smart-push script for macOS and Linux via Homebrew
#
# To use this formula:
# 1. Create a GitHub repository for your project
# 2. Create a release with version tag (e.g., v1.0.0)
# 3. Update the URL and SHA256 values below
# 4. Add this formula to your Homebrew tap

class SmartPush < Formula
  desc "Smart Auto-Push to GitHub - Automate Git add/commit/pull/push with smart commit message suggestions"
  homepage "https://github.com/techey-solution/smart-push"  # CUSTOMIZE: Replace with your GitHub org/repo
  url "https://github.com/techey-solution/smart-push/archive/v1.0.0.tar.gz"  # CUSTOMIZE: Replace with your GitHub org/repo and version
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"  # CUSTOMIZE: Replace with actual SHA256 of the tarball
  license "MIT"  # CUSTOMIZE: Replace with your preferred license
  
  # This formula works on both macOS and Linux
  depends_on :linux if OS.linux?
  depends_on "coreutils" if OS.linux?
  
  def install
    # Install the smart-push script to bin directory
    bin.install "smart-push"
    
    # Make sure the script is executable
    chmod 0755, bin/"smart-push"
  end
  
  test do
    # Test that the script exists and is executable
    assert_predicate bin/"smart-push", :exist?
    assert_predicate bin/"smart-push", :executable?
    
    # Test help/usage (if your script supports --help or --version)
    # Uncomment and modify based on your script's help options:
    # assert_match "Smart Auto-Push to GitHub", shell_output("#{bin}/smart-push --help", 1)
  end
  
  # Optional: Add caveats for users
  def caveats
    <<~EOS
      🚀 Smart Push CLI installed successfully!
      
      Usage:
        smart-push [commit-message] [branch-name]
      
      Examples:
        smart-push "Fix user login bug"
        smart-push "Add new feature" feature-branch
      
      The script will automatically:
      - Detect project type (frontend/backend)
      - Suggest smart commit messages
      - Run pre-commit checks
      - Handle git add/commit/pull/push workflow
      
      Make sure you're in a git repository when running the command.
    EOS
  end
end
