#!/bin/bash
# Phone Number Search Tool - Download and Run v2.0
# Downloads and opens in new terminal for proper stdin handling
# 
# Quick start: curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash
# 
# Features:
# - Beautiful Spring Boot-style ASCII art interface
# - Interactive mode for step-by-step input
# - Config mode for automated runs
# - Quick test functionality
# - Multi-platform support (macOS, Linux)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"
LOCAL_DIR="$HOME/zal-bypass-tool"
PYTHON_CMD="python3"
VERSION="2.0.0"

print_header() {
    clear
    echo -e "${CYAN}"
    echo "  ____  _                        ____                      _     "
    echo " |  _ \| |__   ___  _ __   ___  / ___|  ___  __ _ _ __ ___| |__  "
    echo " | |_) | '_ \ / _ \| '_ \ / _ \ \___ \ / _ \/ _\` | '__/ __| '_ \ "
    echo " |  __/| | | | (_) | | | |  __/  ___) |  __/ (_| | | | (__| | | |"
    echo " |_|   |_| |_|\___/|_| |_|\___| |____/ \___|\__,_|_|  \___|_| |_|"
    echo ""
    echo -e "${PURPLE}      ╔══════════════════════════════════════════════════════╗"
    echo -e "      ║              📱 PHONE SEARCH TOOL v${VERSION}              ║"
    echo -e "      ║                Download & Run Script                    ║"
    echo -e "      ╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Automated Download & Setup Tool${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${GREEN}📋 Quick Start Command:${NC}"
    echo -e "${CYAN}   curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash${NC}"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_step() {
    echo -e "${CYAN}🔄 $1${NC}"
}

check_dependencies() {
    print_info "Kiểm tra dependencies..."
    
    # Check Python
    if command -v python3 &> /dev/null; then
        PYTHON_CMD="python3"
        print_success "Python3 đã được cài đặt"
    elif command -v python &> /dev/null; then
        PYTHON_CMD="python"
        print_success "Python đã được cài đặt"
    else
        print_error "Python không được tìm thấy!"
        print_info "Vui lòng cài đặt Python 3.7+ từ https://python.org"
        exit 1
    fi
    
    # Check Git
    if ! command -v git &> /dev/null; then
        print_error "Git không được tìm thấy!"
        print_info "Vui lòng cài đặt Git từ https://git-scm.com"
        exit 1
    fi
}

download_and_setup() {
    print_info "Đang tải xuống từ GitHub..."
    
    # Remove existing directory
    if [[ -d "$LOCAL_DIR" ]]; then
        print_info "Updating to latest version..."
        rm -rf "$LOCAL_DIR"
    fi
    
    git clone "$REPO_URL" "$LOCAL_DIR" --quiet
    
    cd "$LOCAL_DIR"
    
    print_info "Installing dependencies..."
    $PYTHON_CMD -m pip install -r requirements.txt --quiet
    
    print_success "Setup completed!"
}

open_in_terminal() {
    print_info "Opening program in new terminal..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        cat > "$LOCAL_DIR/run_app.sh" << EOF
#!/bin/bash
cd "$LOCAL_DIR"

# Colors for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

show_menu() {
    clear
    echo -e "${CYAN}"
    echo "  ____  _                        ____                      _     "
    echo " |  _ \| |__   ___  _ __   ___  / ___|  ___  __ _ _ __ ___| |__  "
    echo " | |_) | '_ \ / _ \| '_ \ / _ \ \___ \ / _ \/ _\` | '__/ __| '_ \ "
    echo " |  __/| | | | (_) | | | |  __/  ___) |  __/ (_| | | | (__| | | |"
    echo " |_|   |_| |_|\___/|_| |_|\___| |____/ \___|\__,_|_|  \___|_| |_|"
    echo ""
    echo -e "${PURPLE}      ╔══════════════════════════════════════════════════════╗"
    echo -e "      ║                  📱 PHONE SEARCH TOOL                   ║"
    echo -e "      ║                    Version 2.0.0                       ║"
    echo -e "      ╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Welcome to Phone Number Search Tool!${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${GREEN}📋 Select Run Mode:${NC}"
    echo ""
    echo -e "${CYAN}  ${YELLOW}1)${NC} ${GREEN}🔍 Interactive Mode${NC}     ${BLUE}(step-by-step input)${NC}"
    echo -e "${CYAN}  ${YELLOW}2)${NC} ${GREEN}⚙️  Config Mode${NC}         ${BLUE}(use config file)${NC}"
    echo -e "${CYAN}  ${YELLOW}3)${NC} ${GREEN}⚡ Quick Test${NC}           ${BLUE}(quick test)${NC}"
    echo -e "${CYAN}  ${YELLOW}4)${NC} ${RED}🚪 Exit${NC}                ${BLUE}(quit)${NC}"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}💡 Tip: Use Interactive Mode for easy step-by-step input${NC}"
    echo ""
    echo -ne "${YELLOW}🎯 Enter your choice ${GREEN}(1-4)${YELLOW}: ${NC}"
}

# Main menu loop
while true; do
    show_menu
    read choice
    echo ""

    case \$choice in
        1)
            echo -e "${GREEN}🔍 Starting Interactive Mode...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            python3 phone_search.py
            echo ""
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Interactive Mode completed!${NC}"
            echo -e "${CYAN}Press Enter to return to menu...${NC}"
            read
            ;;
        2)
            echo -e "${GREEN}⚙️  Using Config Mode...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            if [[ ! -f "config.json" ]]; then
                echo -e "${YELLOW}📁 Creating new config file from template...${NC}"
                cp config_example.json config.json
                echo -e "${PURPLE}📝 Please edit config.json and run again${NC}"
                open config.json 2>/dev/null || echo -e "${RED}❌ Please edit config.json manually${NC}"
            else
                python3 run_with_config.py config.json
            fi
            echo ""
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Config Mode completed!${NC}"
            echo -e "${CYAN}Press Enter to return to menu...${NC}"
            read
            ;;
        3)
            echo -e "${GREEN}⚡ Running Quick Test...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            python3 quick_start.py
            echo ""
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Quick Test completed!${NC}"
            echo -e "${CYAN}Press Enter to return to menu...${NC}"
            read
            ;;
        4)
            echo -e "${RED}🚪 Goodbye! Thank you for using Phone Search Tool${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Thank you for using Phone Search Tool! ✨${NC}"
            echo -e "${YELLOW}📞 Contact us if you need more support!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid choice! Please select 1-4${NC}"
            echo -e "${YELLOW}🔄 Returning to menu in 2 seconds...${NC}"
            sleep 2
            ;;
    esac
done
EOF
        chmod +x "$LOCAL_DIR/run_app.sh"
        
        # Open in new Terminal window
        osascript << EOF
tell application "Terminal"
    do script "cd '$LOCAL_DIR' && ./run_app.sh"
    activate
end tell
EOF
        
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        cat > "$LOCAL_DIR/run_app.sh" << EOF
#!/bin/bash
cd "$LOCAL_DIR"

# Colors for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

show_menu() {
    clear
    echo -e "${CYAN}"
    echo "  ____  _                        ____                      _     "
    echo " |  _ \| |__   ___  _ __   ___  / ___|  ___  __ _ _ __ ___| |__  "
    echo " | |_) | '_ \ / _ \| '_ \ / _ \ \___ \ / _ \/ _\` | '__/ __| '_ \ "
    echo " |  __/| | | | (_) | | | |  __/  ___) |  __/ (_| | | | (__| | | |"
    echo " |_|   |_| |_|\___/|_| |_|\___| |____/ \___|\__,_|_|  \___|_| |_|"
    echo ""
    echo -e "${PURPLE}      ╔══════════════════════════════════════════════════════╗"
    echo -e "      ║                  📱 PHONE SEARCH TOOL                   ║"
    echo -e "      ║                    Version 2.0.0                       ║"
    echo -e "      ╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Welcome to Phone Number Search Tool!${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${GREEN}📋 Select Run Mode:${NC}"
    echo ""
    echo -e "${CYAN}  ${YELLOW}1)${NC} ${GREEN}🔍 Interactive Mode${NC}     ${BLUE}(step-by-step input)${NC}"
    echo -e "${CYAN}  ${YELLOW}2)${NC} ${GREEN}⚙️  Config Mode${NC}         ${BLUE}(use config file)${NC}"
    echo -e "${CYAN}  ${YELLOW}3)${NC} ${GREEN}⚡ Quick Test${NC}           ${BLUE}(quick test)${NC}"
    echo -e "${CYAN}  ${YELLOW}4)${NC} ${RED}🚪 Exit${NC}                ${BLUE}(quit)${NC}"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}💡 Tip: Use Interactive Mode for easy step-by-step input${NC}"
    echo ""
    echo -ne "${YELLOW}🎯 Enter your choice ${GREEN}(1-4)${YELLOW}: ${NC}"
}

# Main menu loop
while true; do
    show_menu
    read choice
    echo ""

    case \$choice in
        1)
            echo -e "${GREEN}🔍 Starting Interactive Mode...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            python3 phone_search.py
            echo ""
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Interactive Mode completed!${NC}"
            echo -e "${CYAN}Press Enter to return to menu...${NC}"
            read
            ;;
        2)
            echo -e "${GREEN}⚙️  Using Config Mode...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            if [[ ! -f "config.json" ]]; then
                echo -e "${YELLOW}📁 Creating new config file from template...${NC}"
                cp config_example.json config.json
                echo -e "${PURPLE}📝 Please edit config.json and run again${NC}"
                xdg-open config.json 2>/dev/null || echo -e "${RED}❌ Please edit config.json manually${NC}"
            else
                python3 run_with_config.py config.json
            fi
            echo ""
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Config Mode completed!${NC}"
            echo -e "${CYAN}Press Enter to return to menu...${NC}"
            read
            ;;
        3)
            echo -e "${GREEN}⚡ Running Quick Test...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            python3 quick_start.py
            echo ""
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Quick Test completed!${NC}"
            echo -e "${CYAN}Press Enter to return to menu...${NC}"
            read
            ;;
        4)
            echo -e "${RED}🚪 Goodbye! Thank you for using Phone Search Tool${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            echo -e "${PURPLE}✨ Thank you for using Phone Search Tool! ✨${NC}"
            echo -e "${YELLOW}📞 Contact us if you need more support!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid choice! Please select 1-4${NC}"
            echo -e "${YELLOW}🔄 Returning to menu in 2 seconds...${NC}"
            sleep 2
            ;;
    esac
done
EOF
        chmod +x "$LOCAL_DIR/run_app.sh"
        
        # Try different terminal emulators
        if command -v gnome-terminal &> /dev/null; then
            gnome-terminal -- bash -c "$LOCAL_DIR/run_app.sh"
        elif command -v xterm &> /dev/null; then
            xterm -e "$LOCAL_DIR/run_app.sh"
        elif command -v konsole &> /dev/null; then
            konsole -e "$LOCAL_DIR/run_app.sh"
        else
            print_warning "Terminal emulator not found"
            print_info "Run manually: cd $LOCAL_DIR && python3 phone_search.py"
        fi
    else
        print_warning "OS not supported for automatic terminal opening"
        print_info "Run manually: cd $LOCAL_DIR && python3 phone_search.py"
    fi
}

main() {
    print_header
    
    check_dependencies
    download_and_setup
    open_in_terminal
    
    echo ""
    echo -e "${GREEN}🎉 Hoàn thành!${NC}"
    echo ""
    echo -e "${BLUE}📁 Code đã được tải về: $LOCAL_DIR${NC}"
    echo -e "${BLUE}🚀 Chương trình sẽ mở trong terminal mới${NC}"
    echo ""
    echo -e "${YELLOW}💡 Để chạy lại sau này:${NC}"
    echo -e "${BLUE}   cd $LOCAL_DIR && python3 phone_search.py${NC}"
    echo ""
    echo -e "${YELLOW}🗑️ Để gỡ cài đặt:${NC}"
    echo -e "${BLUE}   rm -rf $LOCAL_DIR${NC}"
}

# Run main function
main "$@" 