#!/bin/bash

# Phone Number Search Tool v3.0 - Remote Runner 🛡️
# Advanced Anti-Blocking Edition

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_header() {
    echo -e "${PURPLE}===============================================${NC}"
    echo -e "${CYAN}🛡️  PHONE SEARCH TOOL v3.0 - REMOTE RUNNER  🛡️${NC}"
    echo -e "${PURPLE}===============================================${NC}"
    echo -e "${GREEN}🚀 Advanced Anti-Blocking Technology${NC}"
    echo -e "${YELLOW}⚡ Direct Run from GitHub${NC}"
    echo -e "${PURPLE}===============================================${NC}"
    echo ""
}

print_features() {
    echo -e "${CYAN}🆕 NEW FEATURES v3.0:${NC}"
    echo -e "   ${GREEN}✓ Intelligent Delay System${NC}"
    echo -e "   ${GREEN}✓ User-Agent Rotation${NC}"
    echo -e "   ${GREEN}✓ Human Behavior Simulation${NC}"
    echo -e "   ${GREEN}✓ Auto Blocking Detection & Recovery${NC}"
    echo -e "   ${GREEN}✓ Browser Fingerprint Randomization${NC}"
    echo -e "${PURPLE}===============================================${NC}"
    echo ""
}

check_dependencies() {
    echo -e "${YELLOW}💡 Kiểm tra dependencies...${NC}"
    
    # Check Python3
    if command -v python3 &> /dev/null; then
        echo -e "${GREEN}✅ Python3 đã được cài đặt${NC}"
    else
        echo -e "${RED}❌ Python3 chưa được cài đặt${NC}"
        echo -e "${YELLOW}💡 Hãy cài đặt Python3 trước khi tiếp tục${NC}"
        exit 1
    fi
    
    # Check pip
    if command -v pip3 &> /dev/null || command -v pip &> /dev/null; then
        echo -e "${GREEN}✅ Pip đã được cài đặt${NC}"
    else
        echo -e "${RED}❌ Pip chưa được cài đặt${NC}"
        exit 1
    fi
}

download_project() {
    echo -e "${YELLOW}💡 Đang tải xuống từ GitHub...${NC}"
    
    # Create temp directory
    TEMP_DIR="/tmp/bypass-phone-$(date +%s)"
    
    # Clone repository
    if git clone https://github.com/nhatpm3124/zal-bypass.git "$TEMP_DIR"; then
        echo -e "${GREEN}✅ Tải xuống thành công${NC}"
        cd "$TEMP_DIR"
    else
        echo -e "${RED}❌ Không thể tải xuống từ GitHub${NC}"
        exit 1
    fi
}

install_dependencies() {
    echo -e "${YELLOW}💡 Đang cài đặt dependencies...${NC}"
    
    if pip3 install -r requirements.txt --quiet; then
        echo -e "${GREEN}✅ Dependencies đã được cài đặt${NC}"
    else
        echo -e "${RED}❌ Không thể cài đặt dependencies${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Thiết lập hoàn tất!${NC}"
    echo ""
}

show_menu() {
    echo ""
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}                                                              ${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}    ${CYAN}🛡️  PHONE SEARCH TOOL v3.0 - ANTI-BLOCKING  🛡️${NC}    ${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}                                                              ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}Welcome to Phone Number Search Tool!${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Select Run Mode:${NC}"
    echo ""
    echo -e "  ${GREEN}1)${NC} ${CYAN}Interactive Mode${NC}     (step-by-step input)"
    echo -e "  ${GREEN}2)${NC} ${CYAN}Quick Test${NC}           (test ChromeDriver)"
    echo -e "  ${GREEN}3)${NC} ${CYAN}Config Mode${NC}         (use config file)"
    echo -e "  ${GREEN}4)${NC} ${CYAN}Show Features${NC}       (v3.0 features)"
    echo -e "  ${GREEN}5)${NC} ${CYAN}Exit${NC}                (quit)"
    echo ""
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

run_interactive() {
    echo -e "${CYAN}🔍 Starting Interactive Mode...${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    python3 phone_search.py
}

run_quick_test() {
    echo -e "${CYAN}⚡ Starting Quick Test...${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    python3 quick_start.py
}

run_config_mode() {
    echo -e "${CYAN}⚙️ Starting Config Mode...${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    
    if [ -f "config_example.json" ]; then
        echo -e "${YELLOW}💡 Sử dụng config_example.json...${NC}"
        python3 run_with_config.py config_example.json
    else
        echo -e "${RED}❌ Không tìm thấy config file${NC}"
        echo -e "${YELLOW}💡 Tạo config file mới...${NC}"
        cp config_example.json config.json
        echo -e "${GREEN}✅ Đã tạo config.json${NC}"
        python3 run_with_config.py config.json
    fi
}

show_v3_features() {
    echo ""
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}                   ${CYAN}🚀 VERSION 3.0 FEATURES${NC}                   ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}🛡️ ANTI-BLOCKING TECHNOLOGY:${NC}"
    echo -e "   ${CYAN}✓ Intelligent Delay System${NC} - Adaptive timing with variance"
    echo -e "   ${CYAN}✓ User-Agent Rotation${NC} - 7 realistic browser signatures"
    echo -e "   ${CYAN}✓ Human Behavior Simulation${NC} - Random scroll & mouse movement"
    echo -e "   ${CYAN}✓ Auto Blocking Detection${NC} - Smart detection of blocking attempts"
    echo -e "   ${CYAN}✓ Auto Recovery System${NC} - Automatic recovery when blocked"
    echo -e "   ${CYAN}✓ Browser Fingerprint Randomization${NC} - Advanced stealth mode"
    echo ""
    echo -e "${GREEN}🎨 ENHANCED USER EXPERIENCE:${NC}"
    echo -e "   ${CYAN}✓ Beautiful UI Design${NC} - Professional & modern interface"
    echo -e "   ${CYAN}✓ Real-time Stats${NC} - Anti-blocking performance monitoring"
    echo -e "   ${CYAN}✓ Smart Configuration${NC} - Pre-configured for popular sites"
    echo -e "   ${CYAN}✓ Progress Indicators${NC} - Visual feedback during operations"
    echo ""
    echo -e "${GREEN}🎯 OPTIMIZED FOR:${NC}"
    echo -e "   ${YELLOW}🔥 chat.zalo.me${NC} (pre-configured)"
    echo -e "   ${YELLOW}🔥 Facebook search${NC}"
    echo -e "   ${YELLOW}🔥 High-security websites${NC}"
    echo ""
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

cleanup() {
    echo ""
    echo -e "${YELLOW}💡 Cleaning up...${NC}"
    cd /
    rm -rf "$TEMP_DIR" 2>/dev/null || true
    echo -e "${GREEN}✅ Cleanup completed!${NC}"
    echo ""
}

main() {
    # Set trap for cleanup on exit
    trap cleanup EXIT
    
    print_header
    print_features
    check_dependencies
    download_project
    install_dependencies
    
    while true; do
        show_menu
        
        # Handle stdin for remote execution
        if [[ -t 0 ]]; then
            # Normal terminal input
            read -p "Enter your choice (1-5): " choice
        else
            # Remote execution - redirect from /dev/tty
            exec < /dev/tty
            read -p "Enter your choice (1-5): " choice
        fi
        echo ""
        
        case $choice in
            1)
                run_interactive
                break
                ;;
            2)
                run_quick_test
                break
                ;;
            3)
                run_config_mode
                break
                ;;
            4)
                show_v3_features
                echo "Press any key to continue..."
                if [[ -t 0 ]]; then
                    read -n 1 -s
                else
                    exec < /dev/tty
                    read -n 1 -s
                fi
                continue
                ;;
            5)
                echo -e "${CYAN}Thanks for using Phone Search Tool v3.0! 🚀${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Invalid option. Please choose 1-5.${NC}"
                echo "Press any key to continue..."
                if [[ -t 0 ]]; then
                    read -n 1 -s
                else
                    exec < /dev/tty
                    read -n 1 -s
                fi
                ;;
        esac
    done
    
    echo ""
    echo -e "${GREEN}🎉 Hoàn thành!${NC}"
    echo -e "${YELLOW}💡 Để cài đặt vĩnh viễn, chạy:${NC}"
    echo -e "${CYAN}curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.sh | bash${NC}"
    echo ""
}

# Run main function
main 