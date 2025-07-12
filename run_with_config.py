#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phone Number Search Tool - Config Version
Chạy với file cấu hình thay vì nhập thủ công
"""

import json
import sys
import os
from phone_search import PhoneNumberSearcher

def load_config(config_file):
    """Tải cấu hình từ file JSON"""
    try:
        with open(config_file, 'r', encoding='utf-8') as f:
            config = json.load(f)
        return config
    except FileNotFoundError:
        print(f"❌ Không tìm thấy file config: {config_file}")
        print("💡 Hãy copy file config_example.json thành config.json và chỉnh sửa")
        return None
    except json.JSONDecodeError as e:
        print(f"❌ Lỗi định dạng JSON: {e}")
        return None

def validate_config(config):
    """Kiểm tra tính hợp lệ của config"""
    required_fields = ['website_url', 'search_box_selector', 'phone_pattern']
    
    for field in required_fields:
        if field not in config or not config[field]:
            print(f"❌ Thiếu trường bắt buộc: {field}")
            return False
    
    # Kiểm tra pattern số điện thoại
    pattern = config['phone_pattern']
    if len(pattern) != 10:
        print(f"❌ Pattern số điện thoại phải có đúng 10 ký tự: {pattern}")
        return False
    
    return True

def run_search_with_config(config_file):
    """Chạy tìm kiếm với file config"""
    print("🔍 Phone Number Search Tool - Config Mode")
    print("=" * 60)
    
    # Tải config
    config = load_config(config_file)
    if not config:
        return
    
    # Kiểm tra config
    if not validate_config(config):
        return
    
    # Hiển thị thông tin config
    print("\n📋 Cấu hình:")
    print(f"🌐 Website: {config['website_url']}")
    print(f"🔍 Search box: {config['search_box_selector']}")
    print(f"📱 Pattern: {config['phone_pattern']}")
    if config.get('target_name'):
        print(f"🎯 Tên cần tìm: {config['target_name']}")
    print(f"⏱️ Delay: {config.get('delay', 1)} giây")
    print(f"📊 Max results: {config.get('max_results', 10)}")
    
    # Xác nhận
    confirm = input("\n❓ Bạn có muốn tiếp tục? (y/n): ").strip().lower()
    if confirm not in ['y', 'yes', 'có']:
        print("❌ Hủy bỏ")
        return
    
    # Khởi tạo searcher
    searcher = PhoneNumberSearcher(
        website_url=config['website_url'],
        search_box_selector=config['search_box_selector'],
        result_selector=config.get('result_selector')
    )
    
    try:
        # Thiết lập driver
        if not searcher.setup_driver(headless=config.get('headless', False)):
            return
        
        # Chạy tìm kiếm
        results = searcher.batch_search(
            pattern=config['phone_pattern'],
            target_name=config.get('target_name'),
            delay=config.get('delay', 1),
            max_results=config.get('max_results', 10)
        )
        
        # Lưu kết quả
        if results:
            filename = config.get('save_filename', 'search_results.json')
            searcher.save_results(results, filename)
            print(f"\n🎉 Hoàn thành! Tìm thấy {len(results)} kết quả.")
            
            # Hiển thị tóm tắt
            print("\n📊 Tóm tắt kết quả:")
            for i, result in enumerate(results[:5], 1):
                print(f"{i}. {result['phone_number']} - {'✓' if result['found_target'] else '✗'}")
            
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

def main():
    """Hàm chính"""
    if len(sys.argv) != 2:
        print("📖 Sử dụng:")
        print("python run_with_config.py config.json")
        print("\n💡 Hướng dẫn:")
        print("1. Copy file config_example.json thành config.json")
        print("2. Chỉnh sửa config.json với thông tin website")
        print("3. Chạy: python run_with_config.py config.json")
        return
    
    config_file = sys.argv[1]
    if not os.path.exists(config_file):
        print(f"❌ File config không tồn tại: {config_file}")
        return
    
    run_search_with_config(config_file)

if __name__ == "__main__":
    main() 