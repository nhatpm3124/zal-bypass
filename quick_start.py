#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Quick Start Script
Script khởi động nhanh để test chương trình
"""

import os
import json
import sys

def create_sample_config():
    """Tạo file config mẫu"""
    config = {
        "website_url": "https://www.google.com",
        "search_box_selector": "input[name='q']",
        "result_selector": "#search",
        "phone_pattern": "098712345x",
        "target_name": "test",
        "delay": 1,
        "max_results": 1,
        "headless": True,
        "save_filename": "test_results.json"
    }
    
    with open('test_config.json', 'w', encoding='utf-8') as f:
        json.dump(config, f, ensure_ascii=False, indent=2)
    
    print("✅ Đã tạo file test_config.json")

def run_test():
    """Chạy test nhanh"""
    print("🔍 Phone Number Search Tool - Quick Start")
    print("=" * 50)
    
    # Kiểm tra dependencies
    try:
        import selenium
        from webdriver_manager.chrome import ChromeDriverManager
        print("✅ Dependencies đã được cài đặt")
    except ImportError as e:
        print(f"❌ Thiếu dependency: {e}")
        print("💡 Chạy: pip install -r requirements.txt")
        return
    
    # Tạo config test
    create_sample_config()
    
    # Chạy test
    print("\n🚀 Chạy test với Google Search...")
    print("Lưu ý: Đây chỉ là test để kiểm tra ChromeDriver hoạt động")
    
    try:
        from phone_search import PhoneNumberSearcher
        
        searcher = PhoneNumberSearcher(
            website_url="https://www.google.com",
            search_box_selector="input[name='q']",
            result_selector="#search"
        )
        
        if searcher.setup_driver(headless=True):
            print("✅ ChromeDriver hoạt động!")
            print("✅ Website tải thành công!")
            searcher.close()
            print("✅ Test hoàn tất!")
        else:
            print("❌ Test thất bại!")
            
    except Exception as e:
        print(f"❌ Lỗi: {e}")
    
    # Hướng dẫn tiếp theo
    print("\n📋 Bước tiếp theo:")
    print("1. Chạy: python phone_search.py")
    print("2. Hoặc: python run_with_config.py test_config.json")
    print("3. Đọc README.md để biết thêm chi tiết")

def main():
    """Hàm chính"""
    if len(sys.argv) > 1 and sys.argv[1] == "clean":
        # Xóa file test
        files_to_remove = ['test_config.json', 'test_results.json']
        for file in files_to_remove:
            if os.path.exists(file):
                os.remove(file)
                print(f"🗑️ Đã xóa {file}")
        print("✅ Dọn dẹp hoàn tất!")
    else:
        run_test()

if __name__ == "__main__":
    main() 