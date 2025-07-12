#!/bin/bash
# One-liner script for quick remote execution
# Usage: curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash

set -e

# Quick setup and run
TEMP_DIR="/tmp/bypass-phone-oneliner-$(date +%s)"
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"

echo "🔍 Phone Number Search Tool - One Liner"
echo "======================================="

# Check dependencies
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "❌ Python not found! Please install Python 3.7+"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git not found! Please install Git"
    exit 1
fi

PYTHON_CMD="python3"
if ! command -v python3 &> /dev/null; then
    PYTHON_CMD="python"
fi

# Download and setup
echo "📥 Downloading from GitHub..."
git clone "$REPO_URL" "$TEMP_DIR" --quiet

cd "$TEMP_DIR"

echo "📦 Installing dependencies..."
$PYTHON_CMD -m pip install -r requirements.txt --quiet

echo "🚀 Running Phone Number Search Tool..."
$PYTHON_CMD phone_search.py

# Cleanup
echo "🧹 Cleaning up..."
cd /
rm -rf "$TEMP_DIR"

echo "✅ Done!" 