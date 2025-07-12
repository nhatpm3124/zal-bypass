#!/bin/bash
# Phone Number Search Tool - Auto Installer
# Cài đặt tự động từ GitHub

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"
INSTALL_DIR="$HOME/bypass-phone"
PYTHON_CMD="python3"

print_header() {
    echo -e "${BLUE}================================================${NC}"
    echo -e "${BLUE}🔍 Phone Number Search Tool - Auto Installer${NC}"
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

check_python() {
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
}

check_git() {
    if ! command -v git &> /dev/null; then
        print_error "Git không được tìm thấy!"
        print_info "Vui lòng cài đặt Git từ https://git-scm.com"
        exit 1
    fi
    print_success "Git đã được cài đặt"
}

check_chrome() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if [[ -d "/Applications/Google Chrome.app" ]]; then
            print_success "Chrome đã được cài đặt"
        else
            print_warning "Chrome không tìm thấy!"
            print_info "Vui lòng cài đặt Chrome từ https://chrome.google.com"
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v google-chrome &> /dev/null || command -v chromium &> /dev/null; then
            print_success "Chrome/Chromium đã được cài đặt"
        else
            print_warning "Chrome/Chromium không tìm thấy!"
            print_info "Vui lòng cài đặt Chrome hoặc Chromium"
        fi
    else
        print_warning "Không thể kiểm tra Chrome trên hệ điều hành này"
    fi
}

install_tool() {
    print_info "Đang cài đặt Phone Number Search Tool..."
    
    # Remove existing installation
    if [[ -d "$INSTALL_DIR" ]]; then
        print_info "Đang xóa bản cài đặt cũ..."
        rm -rf "$INSTALL_DIR"
    fi
    
    # Clone repository
    print_info "Đang tải xuống từ GitHub..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    
    # Navigate to directory
    cd "$INSTALL_DIR"
    
    # Install dependencies
    print_info "Đang cài đặt dependencies..."
    $PYTHON_CMD -m pip install -r requirements.txt
    
    # Make scripts executable
    chmod +x *.sh
    
    print_success "Cài đặt hoàn tất!"
}

create_shortcuts() {
    print_info "Đang tạo shortcuts..."
    
    # Create run script
    cat > "$INSTALL_DIR/run.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
python3 phone_search.py
EOF
    
    # Create config run script
    cat > "$INSTALL_DIR/run_config.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
if [[ ! -f "config.json" ]]; then
    echo "⚠️ File config.json không tồn tại!"
    echo "💡 Copy từ config_example.json và chỉnh sửa:"
    echo "   cp config_example.json config.json"
    exit 1
fi
python3 run_with_config.py config.json
EOF
    
    # Create uninstall script
    cat > "$INSTALL_DIR/uninstall.sh" << EOF
#!/bin/bash
echo "🗑️ Đang gỡ cài đặt Phone Number Search Tool..."
cd "$HOME"
rm -rf "$INSTALL_DIR"
echo "✅ Đã gỡ cài đặt hoàn tất!"
EOF
    
    chmod +x "$INSTALL_DIR"/*.sh
    
    print_success "Đã tạo shortcuts!"
}

show_usage() {
    echo ""
    echo -e "${GREEN}📋 Cách sử dụng:${NC}"
    echo -e "${BLUE}cd $INSTALL_DIR${NC}"
    echo -e "${BLUE}./run.sh                    # Chạy interactive mode${NC}"
    echo -e "${BLUE}./run_config.sh             # Chạy với config file${NC}"
    echo -e "${BLUE}python3 quick_start.py      # Test nhanh${NC}"
    echo -e "${BLUE}./uninstall.sh              # Gỡ cài đặt${NC}"
    echo ""
    echo -e "${GREEN}📖 Hướng dẫn chi tiết:${NC}"
    echo -e "${BLUE}cat README.md${NC}"
    echo ""
    echo -e "${GREEN}🎯 Để chạy ngay:${NC}"
    echo -e "${BLUE}cd $INSTALL_DIR && ./run.sh${NC}"
}

main() {
    print_header
    
    echo "🔍 Kiểm tra hệ thống..."
    check_python
    check_git
    check_chrome
    
    echo ""
    echo "📦 Đang cài đặt..."
    install_tool
    create_shortcuts
    
    echo ""
    print_success "🎉 Cài đặt thành công!"
    show_usage
}

# Run main function
main "$@" 