# Phone Number Search Tool

Công cụ tìm kiếm số điện thoại trên website bằng cách thử các tổ hợp số còn thiếu.

## 🚀 Chạy trực tiếp từ GitHub (Không cần tải về)

### ⚡ Quick Test (Không cần input, chỉ test ChromeDriver)
```bash
# macOS/Linux - Test nhanh không cần nhập gì
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash

# Windows PowerShell
iwr -useb https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.ps1 | iex -QuickRun
```

### 🎯 Interactive Mode (Nhập thông tin website) - KHUYẾN NGHỊ
```bash
# macOS/Linux - Tải về và mở terminal mới (giải quyết vấn đề input)
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash

# Hoặc tải về thư mục hiện tại và chạy thủ công
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/interactive.sh | bash
# Sau đó chạy: cd zal-bypass-interactive && python3 phone_search.py
```

### 🎛️ Menu với nhiều lựa chọn
```bash
# macOS/Linux - Menu lựa chọn nhiều chế độ
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/run_remote.sh | bash
```

### 💾 Cài đặt vĩnh viễn
```bash
# macOS/Linux
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.sh | bash

# Windows PowerShell
iwr -useb https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.ps1 | iex
```

## 📁 Cấu trúc dự án

```
bypass-phone/
├── phone_search.py          # Chương trình chính (interactive mode)
├── run_with_config.py       # Chạy với file config
├── config_example.json      # Mẫu file cấu hình
├── quick_start.py           # Script test nhanh
├── install.sh               # Auto installer cho macOS/Linux
├── install.ps1              # Auto installer cho Windows
├── run_remote.sh            # Remote runner với menu
├── one_liner.sh             # Quick test (không cần input)
├── interactive.sh           # Setup và hướng dẫn chạy
├── download_and_run.sh      # Tải về và mở terminal mới
├── requirements.txt         # Dependencies
├── README.md               # Hướng dẫn sử dụng
└── .gitignore              # Git ignore file
```

## Tính năng

- ✅ Nhập pattern số điện thoại với các số chưa biết
- ✅ Tự động tìm kiếm trên website
- ✅ Dừng khi tìm thấy tên cần tìm
- ✅ Lưu kết quả tìm kiếm vào file JSON
- ✅ Hỗ trợ tùy chỉnh thời gian chờ và số kết quả tối đa
- ✅ Tự động quản lý ChromeDriver
- ✅ Chống phát hiện với User-Agent ngẫu nhiên
- ✅ **Chạy trực tiếp từ GitHub không cần tải về**
- ✅ **Giải quyết vấn đề stdin với remote execution**

## Cài đặt thủ công

### 1. Cài đặt Python
Đảm bảo bạn đã cài đặt Python 3.7+ trên máy.

### 2. Clone repository
```bash
git clone https://github.com/nhatpm3124/zal-bypass.git
cd zal-bypass
```

### 3. Cài đặt dependencies
```bash
pip install -r requirements.txt
```

### 4. Cài đặt Chrome Browser
Chương trình sẽ tự động tải ChromeDriver, nhưng bạn cần cài đặt Chrome Browser trước.

## Sử dụng

### Cách 1: Chạy tương tác (Khuyến nghị cho lần đầu)
```bash
python phone_search.py
```

### Cách 2: Chạy với config file (Nhanh hơn)
```bash
# Copy và chỉnh sửa file config
cp config_example.json config.json
# Chỉnh sửa config.json theo website của bạn
# Chạy với config
python run_with_config.py config.json
```

### Cách 3: Quick test
```bash
python quick_start.py
```

### Cách nhập thông tin

1. **URL website**: Nhập đầy đủ URL của website cần tìm kiếm
   ```
   Ví dụ: https://example.com/search
   ```

2. **CSS Selector của ô tìm kiếm**: Cần inspect element để tìm
   ```
   Ví dụ: #search-box
   Ví dụ: input[name="phone"]
   Ví dụ: .search-input
   ```

3. **CSS Selector khu vực kết quả** (Tùy chọn):
   ```
   Ví dụ: .search-results
   Ví dụ: #results-container
   ```

4. **Pattern số điện thoại**: Sử dụng 'x' hoặc '?' cho số chưa biết
   ```
   Ví dụ: 098x123xxx (biết 0987123, thiếu 3 số cuối)
   Ví dụ: 0987?????5 (biết đầu 0987 và cuối 5)
   Ví dụ: 09xxxxxxxx (chỉ biết 09)
   ```

## 💡 Lời khuyên tối ưu

### Pattern hiệu quả:
- ❌ **Tránh**: `0888xxxxxx` (1 triệu tổ hợp)
- ✅ **Tốt**: `0888123xxx` (1,000 tổ hợp)  
- ✅ **Tốt nhất**: `088812345x` (10 tổ hợp)

### Thời gian chờ:
- Website thông thường: 1-2 giây
- Website chậm: 3-5 giây  
- Tránh bị chặn: ≥1 giây

### Số lượng kết quả:
- Test: 1-5 kết quả
- Thực tế: 10-50 kết quả
- Thu thập lớn: 100+ kết quả

## Ví dụ sử dụng

### Ví dụ 1: Quick Test từ GitHub
```bash
# Chỉ test ChromeDriver, không cần nhập gì
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash
```

### Ví dụ 2: Interactive Mode từ GitHub (KHUYẾN NGHỊ)
```bash
# Tải về và mở terminal mới - GIẢI PHÁP TỐT NHẤT
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash

# Hoặc setup thủ công
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/interactive.sh | bash
cd zal-bypass-interactive && python3 phone_search.py
```

### Ví dụ 3: Tìm số điện thoại cụ thể (Local)
```bash
python phone_search.py
```
```
URL website: https://example.com/phonebook
CSS selector ô tìm kiếm: #phone-search
CSS selector kết quả: .search-results
Pattern số điện thoại: 098712345x
Tên cần tìm: Nguyễn Văn A
Thời gian chờ: 2
Số kết quả tối đa: 1
Chạy ẩn trình duyệt: n
```

### Ví dụ 4: Sử dụng config file
```json
{
  "website_url": "https://example.com/search",
  "search_box_selector": "#search-input",
  "result_selector": ".search-results",
  "phone_pattern": "098712345x",
  "target_name": "Nguyễn Văn A",
  "delay": 2,
  "max_results": 1,
  "headless": false
}
```

## Cách tìm CSS Selector

1. **Mở trang web** cần tìm kiếm
2. **Nhấn F12** để mở Developer Tools
3. **Nhấn Ctrl+Shift+C** để kích hoạt inspect element
4. **Click vào ô tìm kiếm** trên trang web
5. **Copy CSS selector**:
   - Chuột phải vào element được highlight
   - Chọn "Copy" > "Copy selector"

## Kết quả

Chương trình sẽ tạo file `search_results.json` chứa:
```json
[
  {
    "phone_number": "0987123456",
    "result_text": "Nguyễn Văn A - 0987123456",
    "found_target": true,
    "timestamp": 1699123456.789
  }
]
```

## Lưu ý quan trọng

⚠️ **Sử dụng có trách nhiệm**:
- Chỉ sử dụng cho mục đích hợp pháp
- Tuân thủ Terms of Service của website
- Không spam hoặc gây quá tải cho server
- Đặt thời gian chờ hợp lý (≥1 giây)

⚠️ **Giới hạn**:
- Một số website có CAPTCHA hoặc rate limiting
- Có thể cần proxy hoặc rotate IP cho số lượng lớn
- Cần kiểm tra robots.txt của website

## Troubleshooting

### Lỗi "ChromeDriver not found"
```bash
# Cài đặt lại webdriver-manager
pip install --upgrade webdriver-manager
```

### Lỗi "Element not found"
- Kiểm tra lại CSS selector
- Thử chờ lâu hơn để trang tải
- Kiểm tra xem element có trong iframe không

### Lỗi "Timeout"
- Tăng thời gian chờ
- Kiểm tra kết nối internet
- Thử với website khác

### Website chặn
- Tăng thời gian chờ giữa các request
- Sử dụng proxy
- Thay đổi User-Agent
- Chạy ở chế độ headless

### Lỗi stdin/input khi chạy remote scripts ⭐ MỚI
```bash
# GIẢI PHÁP TỐT NHẤT: Sử dụng download_and_run.sh
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash

# Hoặc setup thủ công
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/interactive.sh | bash
cd zal-bypass-interactive && python3 phone_search.py

# Hoặc download về local
git clone https://github.com/nhatpm3124/zal-bypass.git
cd zal-bypass
python phone_search.py
```

### Lỗi khi chạy remote scripts
```bash
# Nếu curl không hoạt động, thử wget
wget -qO- https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash

# Nếu có lỗi permissions
chmod +x script.sh
```

## Tính năng nâng cao

### Chạy với nhiều pattern
```bash
# Tạo nhiều config file
cp config_example.json config1.json
cp config_example.json config2.json
# Chạy song song
python run_with_config.py config1.json &
python run_with_config.py config2.json &
```

### Tối ưu hiệu suất
- Sử dụng headless mode: `"headless": true`
- Giảm delay: `"delay": 0.5`
- Tăng max_results: `"max_results": 100`

### Deployment options
```bash
# Chạy trên server
nohup python phone_search.py > output.log 2>&1 &

# Chạy với Docker (nếu có Dockerfile)
docker run -it phone-search-tool

# Chạy với systemd service
sudo systemctl start phone-search
```

## So sánh các script

| Script | Mục đích | Input cần thiết | Terminal mới | Phù hợp cho |
|--------|----------|----------------|--------------|-------------|
| `one_liner.sh` | Quick test ChromeDriver | Không | Không | Demo nhanh |
| `download_and_run.sh` | **Interactive đầy đủ** | **Có** | **Có** | **KHUYẾN NGHỊ** |
| `interactive.sh` | Setup thủ công | Có | Không | Advanced users |
| `run_remote.sh` | Menu lựa chọn | Có | Không | Linh hoạt |
| `install.sh` | Cài đặt vĩnh viễn | Ít | Không | Setup lâu dài |

**🎯 Khuyến nghị**: Sử dụng `download_and_run.sh` cho trải nghiệm tốt nhất!

## Changelog

### v2.3 (Latest)
- ✅ **Thêm `download_and_run.sh` - Giải pháp hoàn hảo cho stdin**
- ✅ Tự động mở terminal mới trên macOS/Linux
- ✅ Cải thiện trải nghiệm người dùng với remote execution
- ✅ Cập nhật hướng dẫn chi tiết

### v2.2
- ✅ **Sửa lỗi stdin với remote execution**
- ✅ Tách riêng one-liner (quick test) và interactive mode
- ✅ Thêm script `interactive.sh` cho chế độ tương tác
- ✅ Cải thiện hướng dẫn sử dụng

### v2.1
- ✅ **Chạy trực tiếp từ GitHub**
- ✅ One-liner execution
- ✅ Remote runner với menu
- ✅ Auto installer cho Windows/macOS/Linux
- ✅ PowerShell support cho Windows

### v2.0
- ✅ Tự động quản lý ChromeDriver
- ✅ Chống phát hiện automation
- ✅ Hỗ trợ nhiều biến thể tên
- ✅ Cải thiện hiệu suất
- ✅ Dọn dẹp code và cấu trúc

### v1.0
- ✅ Tính năng cơ bản
- ✅ Pattern matching
- ✅ Config file support

## Đóng góp

Chúng tôi hoan nghênh mọi đóng góp! Vui lòng:
1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## Liên hệ

- GitHub Issues: Báo cáo lỗi và đề xuất tính năng
- Email: your-email@example.com
- Telegram: @your-username

## License

MIT License - Xem file LICENSE để biết chi tiết.

---

⭐ **Nếu công cụ hữu ích, hãy cho một star trên GitHub!** ⭐ 