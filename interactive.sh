#!/bin/bash
# Phone Number Search Tool - Interactive Runner
# Downloads to local directory and runs interactively to avoid stdin issues

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"
LOCAL_DIR="./zal-bypass-temp"
PYTHON_CMD="python3"

print_header() {
    echo -e "${BLUE}================================================${NC}"
    echo -e "${BLUE}🔍 Phone Number Search Tool - Interactive Mode${NC}"
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
    rm -rf "$LOCAL_DIR"
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
    print_info "Đang tải xuống từ GitHub vào thư mục hiện tại..."
    
    # Remove existing directory
    if [[ -d "$LOCAL_DIR" ]]; then
        rm -rf "$LOCAL_DIR"
    fi
    
    git clone "$REPO_URL" "$LOCAL_DIR" --quiet
    
    cd "$LOCAL_DIR"
    
    print_info "Đang cài đặt dependencies..."
    $PYTHON_CMD -m pip install -r requirements.txt --quiet
    
    print_success "Thiết lập hoàn tất!"
}

run_interactive() {
    print_info "Chạy Interactive Mode..."
    echo ""
    echo -e "${YELLOW}💡 Lưu ý: Bạn có thể nhập thông tin tương tác bây giờ${NC}"
    echo ""
    
    # Run in interactive mode
    $PYTHON_CMD phone_search.py
}

main() {
    print_header
    
    check_dependencies
    download_and_setup
    run_interactive
    
    echo ""
    echo -e "${GREEN}🎉 Hoàn thành!${NC}"
    echo ""
    echo -e "${BLUE}💡 Nếu muốn giữ lại code, copy thư mục:${NC}"
    echo -e "${BLUE}   cp -r $LOCAL_DIR ~/phone-search-tool${NC}"
    echo ""
    echo -e "${BLUE}💡 Để cài đặt vĩnh viễn:${NC}"
    echo -e "${BLUE}   curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.sh | bash${NC}"
}

# Run main function
main "$@" 