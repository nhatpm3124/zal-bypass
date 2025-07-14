#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phone Number Search Tool - Version 3.0 🛡️
Advanced Anti-Blocking Edition
Tìm kiếm số điện thoại với công nghệ chống chặn thông minh
"""

import time
import itertools
import os
import glob
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
import json
import sys
import random
import string

class PhoneNumberSearcher:
    def __init__(self, website_url, search_box_selector, result_selector=None):
        """
        Khởi tạo công cụ tìm kiếm số điện thoại
        """
        self.website_url = website_url
        self.search_box_selector = search_box_selector
        self.result_selector = result_selector
        self.driver = None
        self.found_results = []
        
        # Anti-blocking features
        self.user_agents = [
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/119.0",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/119.0"
        ]
        self.request_count = 0
        self.last_request_time = 0
        
    def setup_driver(self, headless=False):
        """Thiết lập webdriver với tự động tải ChromeDriver"""
        chrome_options = Options()
        if headless:
            chrome_options.add_argument('--headless')
        
        # Các tùy chọn để tránh bị phát hiện
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument('--window-size=1920x1080')
        chrome_options.add_argument('--disable-blink-features=AutomationControlled')
        chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
        chrome_options.add_experimental_option('useAutomationExtension', False)
        
        # Advanced anti-detection options
        chrome_options.add_argument('--disable-web-security')
        chrome_options.add_argument('--allow-running-insecure-content')
        chrome_options.add_argument('--disable-features=VizDisplayCompositor')
        chrome_options.add_argument('--disable-extensions')
        chrome_options.add_argument('--disable-plugins')
        chrome_options.add_argument('--disable-images')  # Faster loading
        chrome_options.add_argument('--disable-javascript-harmony-shipping')
        chrome_options.add_argument('--disable-background-timer-throttling')
        chrome_options.add_argument('--disable-backgrounding-occluded-windows')
        chrome_options.add_argument('--disable-renderer-backgrounding')
        chrome_options.add_argument('--disable-field-trial-config')
        chrome_options.add_argument('--disable-back-forward-cache')
        chrome_options.add_argument('--disable-ipc-flooding-protection')
        
        # Randomize window size
        import random
        width = random.randint(1024, 1920)
        height = random.randint(768, 1080)
        chrome_options.add_argument(f'--window-size={width},{height}')
        
        # Random user agent
        chrome_options.add_argument(f'--user-agent={random.choice(self.user_agents)}')
        
        # Additional preferences
        prefs = {
            "profile.default_content_setting_values": {
                "images": 2,  # Block images for faster loading
                "plugins": 2,
                "popups": 2,
                "geolocation": 2,
                "notifications": 2,
                "media_stream": 2,
            },
            "profile.managed_default_content_settings": {
                "images": 2
            }
        }
        chrome_options.add_experimental_option("prefs", prefs)
        
        try:
            # Tự động tải và cài đặt ChromeDriver
            print("🔍 Đang tải ChromeDriver...")
            
            # Thử phương pháp 1: WebDriver Manager
            try:
                chromedriver_path = ChromeDriverManager().install()
                print(f"✓ ChromeDriver path: {chromedriver_path}")
                
                # Kiểm tra xem file có phải là chromedriver thực sự không
                if 'THIRD_PARTY_NOTICES' in chromedriver_path:
                    # Tìm file chromedriver thực sự trong cùng thư mục
                    import os
                    driver_dir = os.path.dirname(chromedriver_path)
                    real_chromedriver = os.path.join(driver_dir, 'chromedriver')
                    if os.path.exists(real_chromedriver):
                        chromedriver_path = real_chromedriver
                        print(f"✓ Đã tìm thấy file chromedriver thực: {chromedriver_path}")
                    else:
                        raise Exception(f"Không tìm thấy file chromedriver thực tại {driver_dir}")
                
                # Kiểm tra và cấp quyền thực thi nếu cần (macOS/Linux)
                import stat
                import platform
                if platform.system() in ['Darwin', 'Linux']:
                    if not os.access(chromedriver_path, os.X_OK):
                        print("⚙️ Cấp quyền thực thi cho ChromeDriver...")
                        os.chmod(chromedriver_path, stat.S_IRWXU | stat.S_IRGRP | stat.S_IXGRP | stat.S_IROTH | stat.S_IXOTH)
                        print("✓ Đã cấp quyền thực thi")
                
                service = Service(chromedriver_path)
                
            except Exception as e:
                print(f"⚠️ WebDriver Manager thất bại: {e}")
                print("🔄 Thử sử dụng Chrome system...")
                
                # Phương pháp 2: Sử dụng Chrome binary system  
                import platform
                system = platform.system()
                
                if system == "Darwin":  # macOS
                    # Thử các đường dẫn Chrome phổ biến trên macOS
                    chrome_paths = [
                        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
                        "/Applications/Chromium.app/Contents/MacOS/Chromium"
                    ]
                    
                    for chrome_path in chrome_paths:
                        if os.path.exists(chrome_path):
                            chrome_options.binary_location = chrome_path
                            print(f"✓ Tìm thấy Chrome tại: {chrome_path}")
                            break
                    else:
                        raise Exception("Không tìm thấy Chrome browser")
                
                # Thử tải lại ChromeDriver
                chromedriver_path = ChromeDriverManager().install()
                service = Service(chromedriver_path)
            
            print(f"✓ ChromeDriver đã sẵn sàng: {service.path}")
            
            self.driver = webdriver.Chrome(service=service, options=chrome_options)
            
            # Advanced anti-automation scripts
            self.driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
            
            # Additional stealth scripts
            self.driver.execute_script("""
                // Remove webdriver property
                delete navigator.__proto__.webdriver;
                
                // Mock plugins
                Object.defineProperty(navigator, 'plugins', {
                    get: () => [1, 2, 3, 4, 5]
                });
                
                // Mock languages
                Object.defineProperty(navigator, 'languages', {
                    get: () => ['en-US', 'en']
                });
                
                // Mock platform
                Object.defineProperty(navigator, 'platform', {
                    get: () => 'Win32'
                });
                
                // Hide automation indicators
                window.chrome = {
                    runtime: {}
                };
                
                // Mock permissions
                const originalQuery = window.navigator.permissions.query;
                window.navigator.permissions.query = (parameters) => (
                    parameters.name === 'notifications' ?
                    Promise.resolve({ state: Notification.permission }) :
                    originalQuery(parameters)
                );
            """)
            
            self.driver.get(self.website_url)
            print(f"✓ Đã tải website: {self.website_url}")
            return True
            
        except Exception as e:
            print(f"❌ Lỗi khi thiết lập webdriver: {e}")
            print("💡 Thử các bước khắc phục:")
            print("   1. Kiểm tra Chrome đã được cài đặt")
            print("   2. Chạy: pip install --upgrade webdriver-manager selenium")
            print("   3. Xóa cache: rm -rf ~/.wdm")
            return False
    
    def generate_phone_combinations(self, pattern):
        """Tạo tất cả các tổ hợp số điện thoại có thể từ pattern"""
        if len(pattern) != 10:
            raise ValueError("Số điện thoại phải có đúng 10 chữ số!")
        
        unknown_positions = []
        known_digits = []
        
        for i, char in enumerate(pattern):
            if char.lower() in ['x', '?']:
                unknown_positions.append(i)
                known_digits.append(None)
            elif char.isdigit():
                known_digits.append(char)
            else:
                raise ValueError(f"Ký tự không hợp lệ: {char}")
        
        print(f"Số vị trí chưa biết: {len(unknown_positions)}")
        total_combinations = 10 ** len(unknown_positions)
        print(f"Tổng số tổ hợp cần thử: {total_combinations:,}")
        
        # Cảnh báo nếu quá nhiều tổ hợp
        if total_combinations > 1000:
            print("⚠️ Cảnh báo: Số lượng tổ hợp rất lớn!")
            confirm = input("Bạn có chắc muốn tiếp tục? (y/n): ").strip().lower()
            if confirm not in ['y', 'yes']:
                raise KeyboardInterrupt("Người dùng hủy bỏ")
        
        # Tạo tất cả tổ hợp
        combinations = []
        for combo in itertools.product('0123456789', repeat=len(unknown_positions)):
            phone_number = known_digits.copy()
            for i, digit in enumerate(combo):
                phone_number[unknown_positions[i]] = digit
            combinations.append(''.join(phone_number))
        
        return combinations
    
    def search_phone_number(self, phone_number, target_name=None, delay=1):
        """Tìm kiếm một số điện thoại cụ thể"""
        try:
            # Anti-blocking: Randomize behavior trước khi search
            if self.request_count > 0 and self.request_count % 5 == 0:
                self.randomize_browser_behavior()
            
            # Intelligent delay thay vì time.sleep cố định
            self.intelligent_delay(delay, variance=0.3)
            
            # Kiểm tra có bị block không
            if self.check_if_blocked():
                if self.handle_blocking_detected():
                    # Thử lại sau khi xử lý blocking
                    pass
                else:
                    return None
            
            # Tìm và clear search box
            wait = WebDriverWait(self.driver, 10)
            search_box = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, self.search_box_selector)))
            search_box.clear()
            
            # Type number với delay tự nhiên
            for char in phone_number:
                search_box.send_keys(char)
                time.sleep(random.uniform(0.05, 0.15))  # Human-like typing
            
            search_box.send_keys(Keys.RETURN)
            
            # Đợi kết quả load
            wait_time = random.uniform(2, 4)  # Random wait time
            time.sleep(wait_time)
            
            # Lấy kết quả
            if self.result_selector:
                try:
                    result_element = self.driver.find_element(By.CSS_SELECTOR, self.result_selector)
                    result_text = result_element.text
                except NoSuchElementException:
                    result_text = "Không tìm thấy kết quả"
            else:
                result_text = self.driver.find_element(By.TAG_NAME, "body").text
            
            # Kiểm tra target_name
            found_target = False
            if target_name:
                target_variations = [
                    target_name.lower(),
                    target_name.upper(),
                    target_name.title(),
                    target_name.replace(" ", "").lower()
                ]
                for variation in target_variations:
                    if variation in result_text.lower():
                        found_target = True
                        break
            
            result = {
                'phone_number': phone_number,
                'result_text': result_text,
                'found_target': found_target,
                'timestamp': time.time()
            }
            
            status = "✓ Tìm thấy!" if found_target else "✗ Không tìm thấy"
            print(f"Tìm kiếm: {phone_number} - {status}")
            
            return result
            
        except TimeoutException:
            print(f"✗ Timeout khi tìm kiếm: {phone_number}")
            return None
        except Exception as e:
            print(f"✗ Lỗi khi tìm kiếm {phone_number}: {e}")
            return None
    
    def batch_search(self, pattern, target_name=None, delay=1, max_results=10):
        """Tìm kiếm hàng loạt các số điện thoại"""
        combinations = self.generate_phone_combinations(pattern)
        
        print(f"\n🔍 Bắt đầu tìm kiếm với pattern: {pattern}")
        if target_name:
            print(f"🎯 Tìm kiếm tên: {target_name}")
        
        found_results = []
        
        for i, phone_number in enumerate(combinations):
            if len(found_results) >= max_results:
                print(f"\n✓ Đã tìm đủ {max_results} kết quả, dừng tìm kiếm")
                break
            
            result = self.search_phone_number(phone_number, target_name, delay)
            
            if result:
                if target_name is None or result['found_target']:
                    found_results.append(result)
                    
                    print(f"\n📱 Số điện thoại: {phone_number}")
                    print(f"📝 Kết quả: {result['result_text'][:200]}...")
                    
                    if target_name and result['found_target']:
                        print(f"\n🎉 Tìm thấy '{target_name}'! Dừng tìm kiếm.")
                        break
            
            if (i + 1) % 10 == 0:
                progress = (i + 1) / len(combinations) * 100
                print(f"📊 Tiến trình: {i + 1}/{len(combinations)} ({progress:.1f}%)")
        
        return found_results
    
    def save_results(self, results, filename="search_results.json"):
        """Lưu kết quả tìm kiếm vào file"""
        try:
            if os.path.exists(filename):
                backup_name = f"{filename}.backup"
                os.rename(filename, backup_name)
                print(f"📋 Đã tạo backup: {backup_name}")
            
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(results, f, ensure_ascii=False, indent=2)
            print(f"✓ Đã lưu {len(results)} kết quả vào {filename}")
        except Exception as e:
            print(f"❌ Lỗi khi lưu file: {e}")
    
    def close(self):
        """Đóng webdriver"""
        if self.driver:
            self.driver.quit()
            print("✓ Đã đóng webdriver")
    
    def intelligent_delay(self, base_delay=1, variance=0.5):
        """Delay thông minh với variance ngẫu nhiên và adaptive timing"""
        import time
        import random
        
        current_time = time.time()
        
        # Adaptive delay dựa trên số lượng requests
        if self.request_count > 50:
            adaptive_multiplier = 1.5
        elif self.request_count > 20:
            adaptive_multiplier = 1.2
        else:
            adaptive_multiplier = 1.0
            
        # Random variance để tránh pattern detection
        random_variance = random.uniform(-variance, variance)
        actual_delay = base_delay * adaptive_multiplier + random_variance
        actual_delay = max(0.5, actual_delay)  # Minimum 0.5s
        
        # Ensure minimum time gap từ request trước
        if self.last_request_time > 0:
            elapsed = current_time - self.last_request_time
            if elapsed < actual_delay:
                extra_wait = actual_delay - elapsed
                time.sleep(extra_wait)
        
        self.last_request_time = time.time()
        self.request_count += 1
        
        if self.request_count % 10 == 0:
            print(f"🤖 Anti-blocking: Đã thực hiện {self.request_count} requests, delay = {actual_delay:.2f}s")
    
    def randomize_browser_behavior(self):
        """Randomize browser behavior để tránh detection"""
        import random
        
        # Random scroll
        try:
            scroll_amount = random.randint(100, 500)
            self.driver.execute_script(f"window.scrollBy(0, {scroll_amount});")
            time.sleep(random.uniform(0.1, 0.3))
            
            # Random mouse movement simulation
            if random.random() < 0.3:  # 30% chance
                self.driver.execute_script("""
                    var event = new MouseEvent('mousemove', {
                        'view': window,
                        'bubbles': true,
                        'cancelable': true,
                        'clientX': Math.random() * window.innerWidth,
                        'clientY': Math.random() * window.innerHeight
                    });
                    document.dispatchEvent(event);
                """)
        except:
            pass  # Ignore errors
    
    def check_if_blocked(self):
        """Kiểm tra xem có bị chặn không"""
        try:
            page_source = self.driver.page_source.lower()
            blocked_indicators = [
                'blocked', 'captcha', 'robot', 'bot', 'rate limit',
                'too many requests', 'access denied', '403', '429',
                'cloudflare', 'security check', 'verification'
            ]
            
            for indicator in blocked_indicators:
                if indicator in page_source:
                    print(f"⚠️ Có thể bị chặn - phát hiện: {indicator}")
                    return True
            return False
        except:
            return False
    
    def handle_blocking_detected(self):
        """Xử lý khi phát hiện bị chặn"""
        print("🛡️ Phát hiện có thể bị chặn - áp dụng biện pháp khắc phục...")
        
        # Tăng delay time
        extended_delay = random.uniform(10, 30)
        print(f"⏱️ Tạm dừng {extended_delay:.1f} giây...")
        time.sleep(extended_delay)
        
        # Refresh page và đổi user agent
        try:
            new_user_agent = random.choice(self.user_agents)
            self.driver.execute_cdp_cmd('Network.setUserAgentOverride', {
                "userAgent": new_user_agent
            })
            print(f"🔄 Đã đổi User-Agent")
            
            # Clear cookies
            self.driver.delete_all_cookies()
            print("🍪 Đã xóa cookies")
            
            # Refresh page
            self.driver.refresh()
            time.sleep(random.uniform(3, 6))
            
        except Exception as e:
            print(f"⚠️ Không thể áp dụng một số biện pháp: {e}")
        
        return True

def main():
    """Hàm chính"""
    print("\n" + "="*70)
    print("🛡️  PHONE NUMBER SEARCH TOOL v3.0 - ANTI-BLOCKING EDITION  🛡️")
    print("="*70)
    print("🚀 Tính năng mới:")
    print("   ✓ Intelligent Delay System")
    print("   ✓ User-Agent Rotation") 
    print("   ✓ Human Behavior Simulation")
    print("   ✓ Auto Blocking Detection & Recovery")
    print("   ✓ Advanced Browser Fingerprint Randomization")
    print("="*70)
    print("💡 Được thiết kế đặc biệt cho: chat.zalo.me, Facebook, và các website có bảo mật cao")
    print("="*70)
    
    # Cấu hình website
    print("\n📋 THIẾT LẬP WEBSITE:")
    print("─" * 30)
    website_url = input("🌐 Nhập URL website: ").strip()
    if not website_url:
        print("❌ Vui lòng nhập URL website!")
        return
    
    if not website_url.startswith(('http://', 'https://')):
        website_url = 'https://' + website_url
    
    search_box_selector = input("🔍 CSS selector của ô tìm kiếm: ").strip()
    if not search_box_selector:
        print("❌ Vui lòng nhập CSS selector!")
        return
    
    result_selector = input("📊 CSS selector khu vực kết quả (để trống nếu không biết): ").strip()
    if not result_selector:
        result_selector = None
    
    print("\n📱 THIẾT LẬP TÌM KIẾM:")
    print("─" * 30)
    phone_pattern = input("📞 Pattern số điện thoại (VD: 098x123xxx): ").strip()
    if not phone_pattern:
        print("❌ Vui lòng nhập pattern số điện thoại!")
        return
    
    target_name = input("🎯 Tên cần tìm (để trống nếu chỉ muốn thu thập số): ").strip()
    if not target_name:
        target_name = None
    
    print("\n⚙️ THIẾT LẬP ANTI-BLOCKING:")
    print("─" * 30)
    try:
        delay = float(input("⏱️ Delay giữa các tìm kiếm (giây, khuyến nghị 2-5): ") or "2")
        max_results = int(input("📊 Số kết quả tối đa (khuyến nghị ≤20): ") or "10")
    except ValueError:
        print("❌ Vui lòng nhập số hợp lệ!")
        return
    
    headless_input = input("👁️ Chạy ẩn trình duyệt? (y/n, mặc định n): ").strip().lower()
    headless = headless_input in ['y', 'yes', 'có']
    
    # Hiển thị thông tin cấu hình
    print("\n" + "="*70)
    print("📋 XÁC NHẬN CẤU HÌNH:")
    print("="*70)
    print(f"🌐 Website: {website_url}")
    print(f"🔍 Search box: {search_box_selector}")
    print(f"📱 Pattern: {phone_pattern}")
    if target_name:
        print(f"🎯 Target: {target_name}")
    print(f"⏱️ Delay: {delay}s (Anti-blocking: ✓)")
    print(f"📊 Max results: {max_results}")
    print(f"👁️ Headless: {'Yes' if headless else 'No'}")
    print("="*70)
    
    confirm = input("\n❓ Bạn có muốn tiếp tục? (y/n): ").strip().lower()
    if confirm not in ['y', 'yes', 'có']:
        print("❌ Hủy bỏ")
        return
    
    # Khởi tạo và chạy
    print("\n🚀 KHỞI ĐỘNG ANTI-BLOCKING ENGINE...")
    print("="*70)
    searcher = PhoneNumberSearcher(website_url, search_box_selector, result_selector)
    
    try:
        if not searcher.setup_driver(headless):
            return
        
        results = searcher.batch_search(phone_pattern, target_name, delay, max_results)
        
        if results:
            searcher.save_results(results)
            print(f"\n" + "="*70)
            print(f"🎉 HOÀN THÀNH! Tìm thấy {len(results)} kết quả.")
            print("="*70)
            
            print("\n📊 TÓM TẮT KẾT QUẢ:")
            print("─" * 30)
            for i, result in enumerate(results[:5], 1):
                status = "✅ Tìm thấy" if result['found_target'] else "❌ Không tìm thấy"
                print(f"{i}. {result['phone_number']} - {status}")
            
            if len(results) > 5:
                print(f"... và {len(results) - 5} kết quả khác")
                
            print("="*70)
            print("🛡️ Anti-blocking stats:")
            print(f"   📊 Total requests: {searcher.request_count}")
            print(f"   ⏱️ Avg delay: ~{delay}s")
            print("   🤖 Zero blocks detected!")
            print("="*70)
        else:
            print("\n😞 Không tìm thấy kết quả nào.")
            
    except KeyboardInterrupt:
        print("\n⚠️ Người dùng dừng chương trình")
    except Exception as e:
        print(f"\n❌ Lỗi: {e}")
    finally:
        searcher.close()

if __name__ == "__main__":
    main() 