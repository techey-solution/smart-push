#!/bin/bash

# Build script for smart-push Debian package
# Usage: ./build.sh [version]

set -e

VERSION=${1:-1.0.0}
PACKAGE_NAME="smart-push"
DEB_NAME="${PACKAGE_NAME}_${VERSION}_all.deb"

echo "🔨 Building Debian package: ${DEB_NAME}"

# Check if we're in the right directory
if [ ! -f "smart-push" ] || [ ! -d "debian" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    echo "Expected files: smart-push, debian/"
    exit 1
fi

# Update version in control file if needed
if grep -q "Version: [0-9]" debian/control; then
    sed -i "s/Version: [0-9].*/Version: ${VERSION}/" debian/control
    echo "✅ Updated version in debian/control to ${VERSION}"
fi

# Create temporary build directory
BUILD_DIR=$(mktemp -d)
echo "📁 Using build directory: ${BUILD_DIR}"

# Copy files to build directory
cp smart-push "${BUILD_DIR}/"
cp -r debian "${BUILD_DIR}/"

# Rename debian to DEBIAN (required by dpkg-deb)
cd "${BUILD_DIR}"
mv debian DEBIAN

# Build the package
dpkg-deb --build . "${DEB_NAME}"

# Move package back to original directory
mv "${DEB_NAME}" "${OLDPWD}/"

# Clean up
cd "${OLDPWD}"
rm -rf "${BUILD_DIR}"

echo "✅ Package built successfully: ${DEB_NAME}"
echo "📦 Package size: $(du -h ${DEB_NAME} | cut -f1)"

# Show package info
echo ""
echo "📋 Package information:"
dpkg-deb --info "${DEB_NAME}"
