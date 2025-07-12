#!/bin/bash
# Show all available ways to run Phone Number Search Tool

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔍 Phone Number Search Tool - Usage Guide${NC}"
echo -e "${GREEN}=============================================${NC}"
echo ""

echo -e "${YELLOW}📱 Local Usage (if already downloaded):${NC}"
echo -e "${BLUE}  python phone_search.py              ${NC}# Interactive mode"
echo -e "${BLUE}  python run_with_config.py config.json ${NC}# Config mode"
echo -e "${BLUE}  python quick_start.py               ${NC}# Quick test"
echo ""

echo -e "${YELLOW}🌐 Remote Usage (run from GitHub):${NC}"
echo -e "${BLUE}  # One-liner (fastest)${NC}"
echo -e "${BLUE}  curl -sSL https://raw.githubusercontent.com/your-username/bypass-phone/main/one_liner.sh | bash${NC}"
echo ""
echo -e "${BLUE}  # With menu options${NC}"
echo -e "${BLUE}  curl -sSL https://raw.githubusercontent.com/your-username/bypass-phone/main/run_remote.sh | bash${NC}"
echo ""
echo -e "${BLUE}  # Full installation${NC}"
echo -e "${BLUE}  curl -sSL https://raw.githubusercontent.com/your-username/bypass-phone/main/install.sh | bash${NC}"
echo ""

echo -e "${YELLOW}🪟 Windows PowerShell:${NC}"
echo -e "${BLUE}  # Quick run${NC}"
echo -e "${BLUE}  iwr -useb https://raw.githubusercontent.com/your-username/bypass-phone/main/install.ps1 | iex -QuickRun${NC}"
echo ""
echo -e "${BLUE}  # Full installation${NC}"
echo -e "${BLUE}  iwr -useb https://raw.githubusercontent.com/your-username/bypass-phone/main/install.ps1 | iex${NC}"
echo ""

echo -e "${YELLOW}⚙️ Development:${NC}"
echo -e "${BLUE}  git clone https://github.com/your-username/bypass-phone.git${NC}"
echo -e "${BLUE}  cd bypass-phone${NC}"
echo -e "${BLUE}  pip install -r requirements.txt${NC}"
echo -e "${BLUE}  python phone_search.py${NC}"
echo ""

echo -e "${YELLOW}📋 Config Example:${NC}"
echo -e "${BLUE}  cp config_example.json config.json${NC}"
echo -e "${BLUE}  # Edit config.json with your settings${NC}"
echo -e "${BLUE}  python run_with_config.py config.json${NC}"
echo ""

echo -e "${YELLOW}🔧 Troubleshooting:${NC}"
echo -e "${BLUE}  # If curl fails, try wget${NC}"
echo -e "${BLUE}  wget -qO- https://raw.githubusercontent.com/your-username/bypass-phone/main/one_liner.sh | bash${NC}"
echo ""
echo -e "${BLUE}  # Make scripts executable${NC}"
echo -e "${BLUE}  chmod +x *.sh${NC}"
echo ""

echo -e "${YELLOW}💡 Tips:${NC}"
echo -e "${BLUE}  - Use specific patterns (e.g., 098712345x vs 0987xxxxxx)${NC}"
echo -e "${BLUE}  - Set delay ≥1 second to avoid being blocked${NC}"
echo -e "${BLUE}  - Run in headless mode for better performance${NC}"
echo -e "${BLUE}  - Check robots.txt before mass scanning${NC}"
echo ""

echo -e "${RED}⚠️  Remember: Use responsibly and legally only!${NC}"
echo ""
echo -e "${GREEN}📖 Full documentation: cat README.md${NC}" 