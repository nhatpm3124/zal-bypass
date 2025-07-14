# 🛡️ Anti-Blocking Features Guide

## Tổng quan các tính năng chống chặn

Tool đã được nâng cấp với hệ thống anti-blocking thông minh để tránh bị website phát hiện và chặn.

## 🤖 Tính năng tự động

### 1. Intelligent Delay
- **Adaptive timing**: Delay tăng dần khi số request tăng
- **Random variance**: Thời gian chờ ngẫu nhiên ±0.5s
- **Request spacing**: Đảm bảo khoảng cách tối thiểu giữa các request

### 2. User-Agent Rotation  
- **7 User-Agent khác nhau**: Windows, macOS, Linux, Firefox, Chrome
- **Automatic rotation**: Thay đổi tự động khi phát hiện blocking
- **Real browser signatures**: Sử dụng signature của browser thật

### 3. Browser Behavior Randomization
- **Random scrolling**: Scroll ngẫu nhiên 100-500px mỗi 5 request
- **Mouse movement simulation**: Giả lập di chuột tự nhiên
- **Human-like typing**: Delay 0.05-0.15s giữa các ký tự

### 4. Window & Screen Randomization
- **Random window size**: 1024x768 đến 1920x1080
- **Dynamic viewport**: Thay đổi mỗi lần khởi động
- **Real screen ratios**: Sử dụng tỷ lệ màn hình thật

## 🔍 Phát hiện & Xử lý chặn

### Blocking Detection
Tool tự động phát hiện các dấu hiệu bị chặn:
- Keywords: `blocked`, `captcha`, `robot`, `bot`, `rate limit`
- HTTP codes: `403`, `429`
- Services: `cloudflare`, `security check`

### Auto Recovery
Khi phát hiện bị chặn:
1. **Extended delay**: Dừng 10-30 giây
2. **User-Agent change**: Thay đổi browser signature
3. **Clear cookies**: Xóa session data
4. **Page refresh**: Tải lại trang

## ⚙️ Cấu hình khuyến nghị

### Cho website thông thường:
```json
{
  "delay": 2,
  "max_results": 10,
  "headless": false
}
```

### Cho website có bảo mật cao:
```json
{
  "delay": 5,
  "max_results": 5,
  "headless": true
}
```

### Cho website rất nhạy cảm:
```json
{
  "delay": 10,
  "max_results": 3,
  "headless": true
}
```

## 📊 Monitoring & Logs

Tool hiển thị thông tin anti-blocking:
- `🤖 Anti-blocking: Đã thực hiện X requests, delay = Y.XXs`
- `⚠️ Có thể bị chặn - phát hiện: [keyword]`
- `🛡️ Phát hiện có thể bị chặn - áp dụng biện pháp khắc phục...`
- `🔄 Đã đổi User-Agent`
- `🍪 Đã xóa cookies`

## 🎯 Tips sử dụng hiệu quả

### 1. Chọn delay phù hợp
- **Website nhanh**: 1-2 giây
- **Website trung bình**: 2-5 giây  
- **Website chậm**: 5-10 giây

### 2. Giới hạn số lượng
- **Test**: 1-5 kết quả
- **Sử dụng thông thường**: 5-20 kết quả
- **Thu thập lớn**: Chia thành nhiều session

### 3. Pattern optimization
- **Tránh**: `0888xxxxxx` (1 triệu tổ hợp)
- **Tốt**: `0888123xxx` (1,000 tổ hợp)
- **Tuyệt vời**: `088812345x` (10 tổ hợp)

### 4. Thời gian chạy
- **Tránh giờ cao điểm**: 9-11h, 14-16h
- **Tối ưu**: Chạy ban đêm hoặc cuối tuần
- **Phân tán**: Chia nhỏ thành nhiều session

## 🚨 Warning Signs

### Dấu hiệu cần dừng:
- Thường xuyên gặp CAPTCHA
- Delay tăng lên > 30 giây
- Tỷ lệ timeout > 50%
- Website redirect liên tục

### Khi gặp vấn đề:
1. **Tăng delay**: Gấp đôi thời gian delay
2. **Giảm max_results**: Chia thành batch nhỏ hơn
3. **Đổi mạng**: Sử dụng proxy/VPN
4. **Thay đổi thời gian**: Chạy vào lúc khác

## 📋 Checklist trước khi chạy

- [ ] Đã set delay phù hợp (≥2s)
- [ ] Max results hợp lý (≤20)
- [ ] Pattern không quá rộng (≤1000 tổ hợp)
- [ ] Đã test với số lượng nhỏ trước
- [ ] Có backup plan nếu bị chặn

## 🔧 Advanced Settings

### Cho expert users:
Có thể tùy chỉnh trong code:
- `intelligent_delay()`: Thay đổi logic delay
- `randomize_browser_behavior()`: Thêm behavior mới
- `check_if_blocked()`: Thêm detection rules
- `handle_blocking_detected()`: Custom recovery actions

---

**Lưu ý**: Sử dụng tool có trách nhiệm, tuân thủ Terms of Service của website và luật pháp địa phương. 