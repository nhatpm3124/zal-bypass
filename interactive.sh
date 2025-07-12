#!/bin/bash
# Phone Number Search Tool - Interactive Setup
# Downloads to local directory and provides instructions to run interactively

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"
LOCAL_DIR="./zal-bypass-interactive"
PYTHON_CMD="python3"

print_header() {
    echo -e "${BLUE}================================================${NC}"
    echo -e "${BLUE}🔍 Phone Number Search Tool - Interactive Setup${NC}"
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
        else
            print_success "Chrome đã được cài đặt"
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if ! command -v google-chrome &> /dev/null && ! command -v chromium &> /dev/null; then
            print_warning "Chrome/Chromium không tìm thấy!"
            print_info "Vui lòng cài đặt Chrome hoặc Chromium"
        else
            print_success "Chrome/Chromium đã được cài đặt"
        fi
    fi
}

download_and_setup() {
    print_info "Đang tải xuống từ GitHub..."
    
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

show_instructions() {
    echo ""
    echo -e "${GREEN}🎉 Đã tải xuống và cài đặt thành công!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Để chạy Interactive Mode, thực hiện các lệnh sau:${NC}"
    echo ""
    echo -e "${BLUE}cd $LOCAL_DIR${NC}"
    echo -e "${BLUE}python3 phone_search.py${NC}"
    echo ""
    echo -e "${YELLOW}💡 Hoặc chạy luôn bằng một lệnh:${NC}"
    echo -e "${BLUE}cd $LOCAL_DIR && python3 phone_search.py${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Quick start với file config:${NC}"
    echo -e "${BLUE}cd $LOCAL_DIR${NC}"
    echo -e "${BLUE}cp config_example.json config.json${NC}"
    echo -e "${BLUE}# Chỉnh sửa config.json với thông tin website của bạn${NC}"
    echo -e "${BLUE}python3 run_with_config.py config.json${NC}"
    echo ""
    echo -e "${YELLOW}📖 Đọc hướng dẫn chi tiết:${NC}"
    echo -e "${BLUE}cd $LOCAL_DIR && cat README.md${NC}"
    echo ""
    echo -e "${YELLOW}🗑️ Để xóa sau khi dùng xong:${NC}"
    echo -e "${BLUE}rm -rf $LOCAL_DIR${NC}"
    echo ""
}

main() {
    print_header
    
    check_dependencies
    download_and_setup
    show_instructions
    
    echo -e "${GREEN}✅ Setup hoàn tất! Hãy chạy lệnh trên để bắt đầu.${NC}"
}

# Run main function
main "$@" 