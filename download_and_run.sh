#!/bin/bash
# Phone Number Search Tool - Download and Run
# Downloads and opens in new terminal for proper stdin handling

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatpm3124/zal-bypass.git"
LOCAL_DIR="$HOME/zal-bypass-tool"
PYTHON_CMD="python3"

print_header() {
    echo -e "${BLUE}================================================${NC}"
    echo -e "${BLUE}🔍 Phone Number Search Tool - Download & Run${NC}"
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
}

download_and_setup() {
    print_info "Đang tải xuống từ GitHub..."
    
    # Remove existing directory
    if [[ -d "$LOCAL_DIR" ]]; then
        print_info "Cập nhật phiên bản mới..."
        rm -rf "$LOCAL_DIR"
    fi
    
    git clone "$REPO_URL" "$LOCAL_DIR" --quiet
    
    cd "$LOCAL_DIR"
    
    print_info "Đang cài đặt dependencies..."
    $PYTHON_CMD -m pip install -r requirements.txt --quiet
    
    print_success "Thiết lập hoàn tất!"
}

open_in_terminal() {
    print_info "Mở chương trình trong terminal mới..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        cat > "$LOCAL_DIR/run_app.sh" << EOF
#!/bin/bash
cd "$LOCAL_DIR"
echo "🔍 Phone Number Search Tool"
echo "=========================="
echo ""
echo "Chọn chế độ chạy:"
echo "1) Interactive Mode (nhập thông tin từng bước)"
echo "2) Config Mode (sử dụng file config)"
echo "3) Quick Test"
echo "4) Thoát"
echo ""
read -p "Nhập lựa chọn (1-4): " choice

case \$choice in
    1)
        echo "Chạy Interactive Mode..."
        python3 phone_search.py
        ;;
    2)
        echo "Sử dụng Config Mode..."
        if [[ ! -f "config.json" ]]; then
            echo "Tạo file config mới từ template..."
            cp config_example.json config.json
            echo "Vui lòng chỉnh sửa file config.json và chạy lại"
            open config.json 2>/dev/null || echo "Chỉnh sửa file config.json thủ công"
        else
            python3 run_with_config.py config.json
        fi
        ;;
    3)
        echo "Chạy Quick Test..."
        python3 quick_start.py
        ;;
    4)
        echo "Thoát"
        exit 0
        ;;
    *)
        echo "Lựa chọn không hợp lệ"
        ;;
esac

echo ""
echo "Nhấn Enter để đóng..."
read
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
echo "🔍 Phone Number Search Tool"
echo "=========================="
python3 phone_search.py
echo ""
echo "Nhấn Enter để đóng..."
read
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
            print_warning "Không tìm thấy terminal emulator"
            print_info "Chạy thủ công: cd $LOCAL_DIR && python3 phone_search.py"
        fi
    else
        print_warning "Hệ điều hành không được hỗ trợ mở terminal tự động"
        print_info "Chạy thủ công: cd $LOCAL_DIR && python3 phone_search.py"
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