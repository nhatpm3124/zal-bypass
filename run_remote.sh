#!/bin/bash
# Phone Number Search Tool - Remote Runner
# Chạy trực tiếp từ GitHub mà không cần cài đặt

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"
TEMP_DIR="/tmp/bypass-phone-$(date +%s)"
PYTHON_CMD="python3"

print_header() {
    echo -e "${BLUE}================================================${NC}"
    echo -e "${BLUE}🔍 Phone Number Search Tool - Remote Runner${NC}"
    echo -e "${BLUE}================================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_info() {
    echo -e "${BLUE}💡 $1${NC}"
}

cleanup() {
    print_info "Đang dọn dẹp..."
    rm -rf "$TEMP_DIR"
    print_success "Dọn dẹp hoàn tất!"
}

trap cleanup EXIT

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
    
    # Check Chrome
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if [[ ! -d "/Applications/Google Chrome.app" ]]; then
            print_warning "Chrome không tìm thấy!"
            print_info "Vui lòng cài đặt Chrome từ https://chrome.google.com"
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if ! command -v google-chrome &> /dev/null && ! command -v chromium &> /dev/null; then
            print_warning "Chrome/Chromium không tìm thấy!"
            print_info "Vui lòng cài đặt Chrome hoặc Chromium"
        fi
    fi
}

download_and_setup() {
    print_info "Đang tải xuống từ GitHub..."
    git clone "$REPO_URL" "$TEMP_DIR"
    
    cd "$TEMP_DIR"
    
    print_info "Đang cài đặt dependencies..."
    $PYTHON_CMD -m pip install -r requirements.txt --quiet
    
    print_success "Thiết lập hoàn tất!"
}

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
    echo -e "${CYAN}  ${YELLOW}2)${NC} ${GREEN}⚡ Quick Test${NC}           ${BLUE}(quick test with Google)${NC}"
    echo -e "${CYAN}  ${YELLOW}3)${NC} ${GREEN}⚙️  Config Mode${NC}         ${BLUE}(create config file)${NC}"
    echo -e "${CYAN}  ${YELLOW}4)${NC} ${RED}🚪 Exit${NC}                 ${BLUE}(quit)${NC}"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}💡 Tip: Use Interactive Mode for easy step-by-step input${NC}"
    echo ""
    echo -ne "${YELLOW}🎯 Enter your choice ${GREEN}(1-4)${YELLOW}: ${NC}"
    read choice
    echo ""
    
    case $choice in
        1)
            echo -e "${GREEN}🔍 Starting Interactive Mode...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            $PYTHON_CMD phone_search.py
            ;;
        2)
            echo -e "${GREEN}⚡ Running Quick Test...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            $PYTHON_CMD quick_start.py
            ;;
        3)
            echo -e "${GREEN}⚙️  Starting Config Mode...${NC}"
            echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
            
            # Create config file
            echo -e "${YELLOW}📁 Creating config.json file...${NC}"
            cp config_example.json config.json
            
            # Edit config
            echo -e "${PURPLE}📝 Edit config.json file (press Enter to use default editor):${NC}"
            echo -ne "${CYAN}Editor (nano/vim/code): ${NC}"
            read editor
            
            if [[ -z "$editor" ]]; then
                if command -v nano &> /dev/null; then
                    nano config.json
                elif command -v vim &> /dev/null; then
                    vim config.json
                else
                    print_warning "Không tìm thấy editor, mở file theo cách thủ công"
                    echo "File config tại: $TEMP_DIR/config.json"
                    read -p "Nhấn Enter sau khi chỉnh sửa xong..."
                fi
            else
                $editor config.json
            fi
            
            # Run with config
            print_info "Chạy với config file..."
            $PYTHON_CMD run_with_config.py config.json
            ;;
        4)
            print_info "Thoát chương trình"
            exit 0
            ;;
        *)
            print_error "Lựa chọn không hợp lệ!"
            show_menu
            ;;
    esac
}

main() {
    print_header
    
    check_dependencies
    download_and_setup
    
    show_menu
    
    echo ""
    echo -e "${GREEN}🎉 Hoàn thành!${NC}"
    echo -e "${BLUE}💡 Để cài đặt vĩnh viễn, chạy:${NC}"
    echo -e "${BLUE}curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.sh | bash${NC}"
}

# Run main function
main "$@" 