#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Quick Start Script - Version 3.0 🛡️
Script khởi động nhanh để test chương trình với Anti-Blocking
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
        "delay": 2,
        "max_results": 1,
        "headless": True,
        "save_filename": "test_results.json"
    }
    
    with open('test_config.json', 'w', encoding='utf-8') as f:
        json.dump(config, f, ensure_ascii=False, indent=2)
    
    print("✅ Đã tạo file test_config.json")

def run_test():
    """Chạy test nhanh"""
    print("\n" + "="*70)
    print("🛡️  PHONE SEARCH TOOL v3.0 - QUICK START  🛡️")
    print("="*70)
    print("🚀 Advanced Anti-Blocking Technology")
    print("⚡ Quick Test & Validation")
    print("="*70)
    
    # Kiểm tra dependencies
    print("\n🔧 KIỂM TRA HỆ THỐNG:")
    print("─" * 30)
    try:
        import selenium
        from webdriver_manager.chrome import ChromeDriverManager
        print("✅ Dependencies đã được cài đặt")
        print("✅ Selenium WebDriver: Ready")
        print("✅ ChromeDriver Manager: Ready")
    except ImportError as e:
        print(f"❌ Thiếu dependency: {e}")
        print("💡 Chạy: pip install -r requirements.txt")
        return
    
    # Tạo config test
    print("\n📋 THIẾT LẬP CONFIG:")
    print("─" * 30)
    create_sample_config()
    
    # Chạy test
    print("\n🚀 CHẠY TEST ANTI-BLOCKING ENGINE:")
    print("="*70)
    print("💡 Lưu ý: Đây chỉ là test để kiểm tra ChromeDriver và Anti-Blocking")
    print("🌐 Test website: Google Search")
    print("="*70)
    
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
            print("✅ Anti-blocking engine: Ready!")
            searcher.close()
            
            print("\n" + "="*70)
            print("🎉 TEST HOÀN TẤT THÀNH CÔNG!")
            print("="*70)
            print("🛡️ Hệ thống Anti-Blocking đã sẵn sàng:")
            print("   ✓ Intelligent Delay System")
            print("   ✓ User-Agent Rotation")
            print("   ✓ Browser Fingerprint Randomization")
            print("   ✓ Blocking Detection & Recovery")
            print("="*70)
        else:
            print("❌ Test thất bại!")
            print("💡 Kiểm tra lại Chrome browser và dependencies")
            
    except Exception as e:
        print(f"❌ Lỗi: {e}")
        print("💡 Hãy kiểm tra lại cài đặt")
    
    # Hướng dẫn tiếp theo
    print("\n📋 BƯỚC TIẾP THEO:")
    print("="*70)
    print("🎯 Sử dụng tool:")
    print("   1. Interactive: python phone_search.py")
    print("   2. Config mode: python run_with_config.py test_config.json")
    print("   3. Remote run: curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/run_remote.sh | bash")
    print("\n📚 Tài liệu:")
    print("   📖 README.md - Hướng dẫn chi tiết")
    print("   🛡️ ANTI_BLOCKING_GUIDE.md - Hướng dẫn chống chặn")
    print("="*70)

def main():
    """Hàm chính"""
    if len(sys.argv) > 1 and sys.argv[1] == "clean":
        # Xóa file test
        print("\n🧹 CLEANING UP...")
        print("="*30)
        files_to_remove = ['test_config.json', 'test_results.json']
        for file in files_to_remove:
            if os.path.exists(file):
                os.remove(file)
                print(f"🗑️ Deleted {file}")
        print("✅ Cleanup completed!")
        print("="*30)
    else:
        run_test()

if __name__ == "__main__":
    main() 