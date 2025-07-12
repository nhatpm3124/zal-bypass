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
REPO_URL="https://github.com/your-username/bypass-phone.git"
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
    echo ""
    echo -e "${GREEN}📋 Chọn chế độ chạy:${NC}"
    echo -e "${BLUE}1) Interactive Mode (Nhập thông tin từng bước)${NC}"
    echo -e "${BLUE}2) Quick Test (Test nhanh với Google)${NC}"
    echo -e "${BLUE}3) Config Mode (Tạo config file)${NC}"
    echo -e "${BLUE}4) Exit${NC}"
    echo ""
    read -p "Nhập lựa chọn (1-4): " choice
    
    case $choice in
        1)
            print_info "Chạy Interactive Mode..."
            $PYTHON_CMD phone_search.py
            ;;
        2)
            print_info "Chạy Quick Test..."
            $PYTHON_CMD quick_start.py
            ;;
        3)
            print_info "Chạy Config Mode..."
            
            # Create config file
            echo "Tạo file config.json..."
            cp config_example.json config.json
            
            # Edit config
            echo "Chỉnh sửa file config.json (nhấn Enter để sử dụng editor):"
            read -p "Editor (nano/vim/code): " editor
            
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
    echo -e "${BLUE}curl -sSL https://raw.githubusercontent.com/your-username/bypass-phone/main/install.sh | bash${NC}"
}

# Run main function
main "$@" 