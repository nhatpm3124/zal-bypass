#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phone Number Search Tool - Fixed Version
Tìm kiếm số điện thoại trên website với ChromeDriver path đã sửa
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
        
        # User-Agent ngẫu nhiên
        user_agents = [
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
        ]
        chrome_options.add_argument(f'--user-agent={random.choice(user_agents)}')
        
        try:
            # Tự động tải và cài đặt ChromeDriver
            print("🔍 Đang tải ChromeDriver...")
            service = Service(ChromeDriverManager().install())
            print(f"✓ ChromeDriver đã sẵn sàng: {service.path}")
            
            self.driver = webdriver.Chrome(service=service, options=chrome_options)
            
            # Thêm script để ẩn automation
            self.driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
            
            self.driver.get(self.website_url)
            print(f"✓ Đã tải website: {self.website_url}")
            return True
            
        except Exception as e:
            print(f"❌ Lỗi khi thiết lập webdriver: {e}")
            print("💡 Hãy đảm bảo Chrome đã được cài đặt")
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
        """Tìm kiếm một số điện thoại trên website"""
        try:
            # Tìm ô tìm kiếm
            search_box = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, self.search_box_selector))
            )
            
            # Xóa nội dung cũ và nhập số điện thoại
            search_box.clear()
            
            # Nhập từng ký tự với delay ngẫu nhiên
            for char in phone_number:
                search_box.send_keys(char)
                time.sleep(random.uniform(0.05, 0.15))
            
            search_box.send_keys(Keys.RETURN)
            
            # Chờ kết quả tải
            wait_time = delay + random.uniform(0, 0.5)
            time.sleep(wait_time)
            
            # Lấy kết quả
            result_text = ""
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

def main():
    """Hàm chính"""
    print("🔍 Phone Number Search Tool - Fixed Version")
    print("=" * 60)
    
    # Cấu hình website
    website_url = input("Nhập URL website: ").strip()
    if not website_url:
        print("❌ Vui lòng nhập URL website!")
        return
    
    if not website_url.startswith(('http://', 'https://')):
        website_url = 'https://' + website_url
    
    search_box_selector = input("Nhập CSS selector của ô tìm kiếm: ").strip()
    if not search_box_selector:
        print("❌ Vui lòng nhập CSS selector!")
        return
    
    result_selector = input("Nhập CSS selector khu vực kết quả (để trống nếu không biết): ").strip()
    if not result_selector:
        result_selector = None
    
    phone_pattern = input("Nhập pattern số điện thoại (dùng 'x' cho số chưa biết, VD: 098x123xxx): ").strip()
    if not phone_pattern:
        print("❌ Vui lòng nhập pattern số điện thoại!")
        return
    
    target_name = input("Nhập tên cần tìm (để trống nếu chỉ muốn thu thập số): ").strip()
    if not target_name:
        target_name = None
    
    try:
        delay = float(input("Nhập thời gian chờ giữa các tìm kiếm (giây, mặc định 1): ") or "1")
        max_results = int(input("Nhập số kết quả tối đa cần tìm (mặc định 10): ") or "10")
    except ValueError:
        print("❌ Vui lòng nhập số hợp lệ!")
        return
    
    headless_input = input("Chạy ẩn trình duyệt? (y/n, mặc định n): ").strip().lower()
    headless = headless_input in ['y', 'yes', 'có']
    
    # Khởi tạo và chạy
    searcher = PhoneNumberSearcher(website_url, search_box_selector, result_selector)
    
    try:
        if not searcher.setup_driver(headless):
            return
        
        results = searcher.batch_search(phone_pattern, target_name, delay, max_results)
        
        if results:
            searcher.save_results(results)
            print(f"\n🎉 Hoàn thành! Tìm thấy {len(results)} kết quả.")
            
            print("\n📊 Tóm tắt kết quả:")
            for i, result in enumerate(results[:5], 1):
                status = "✓" if result['found_target'] else "✗"
                print(f"{i}. {result['phone_number']} - {status}")
            
            if len(results) > 5:
                print(f"... và {len(results) - 5} kết quả khác")
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