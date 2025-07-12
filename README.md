# Phone Number Search Tool

A tool for searching phone numbers on websites by trying combinations of missing digits.

## Run Directly from GitHub (No Download Required)

### Quick Test (No input needed, ChromeDriver test only)
```bash
# macOS/Linux - Quick test without input
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash

# Windows PowerShell
iwr -useb https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.ps1 | iex -QuickRun
```

### Interactive Mode (Enter website information) - RECOMMENDED
```bash
# macOS/Linux - Download and open new terminal (solves input issues)
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash

# Or download to current directory and run manually
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/interactive.sh | bash
# Then run: cd zal-bypass-interactive && python3 phone_search.py
```

### Menu with Multiple Options
```bash
# macOS/Linux - Menu selection with multiple modes
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/run_remote.sh | bash
```

### Permanent Installation
```bash
# macOS/Linux
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.sh | bash

# Windows PowerShell
iwr -useb https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/install.ps1 | iex
```

## Project Structure

```
bypass-phone/
├── phone_search.py          # Main program (interactive mode)
├── run_with_config.py       # Run with config file
├── config_example.json      # Configuration template
├── quick_start.py           # Quick test script
├── install.sh               # Auto installer for macOS/Linux
├── install.ps1              # Auto installer for Windows
├── run_remote.sh            # Remote runner with menu
├── one_liner.sh             # Quick test (no input needed)
├── interactive.sh           # Setup and run guide
├── download_and_run.sh      # Download and open new terminal
├── requirements.txt         # Dependencies
├── README.md               # Usage guide
└── .gitignore              # Git ignore file
```

## Features

- Enter phone number pattern with unknown digits
- Automatically search on websites
- Stop when target name is found
- Save search results to JSON file
- Support custom delay and maximum results
- Automatic ChromeDriver management
- Anti-detection with random User-Agent
- Run directly from GitHub without download
- Solve stdin issues with remote execution

## Manual Installation

### 1. Install Python
Ensure you have Python 3.7+ installed on your machine.

### 2. Clone repository
```bash
git clone https://github.com/nhatpm3124/zal-bypass.git
cd zal-bypass
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Install Chrome Browser
The program will automatically download ChromeDriver, but you need to install Chrome Browser first.

## Usage

### Method 1: Interactive Mode (Recommended for first time)
```bash
python phone_search.py
```

### Method 2: Run with config file (Faster)
```bash
# Copy and edit config file
cp config_example.json config.json
# Edit config.json according to your website
# Run with config
python run_with_config.py config.json
```

### Method 3: Quick test
```bash
python quick_start.py
```

### How to Enter Information

1. **Website URL**: Enter the full URL of the website to search
   ```
   Example: https://example.com/search
   ```

2. **CSS Selector for search box**: Need to inspect element to find
   ```
   Example: #search-box
   Example: input[name="phone"]
   Example: .search-input
   ```

3. **CSS Selector for results area** (Optional):
   ```
   Example: .search-results
   Example: #results-container
   ```

4. **Phone number pattern**: Use 'x' or '?' for unknown digits
   ```
   Example: 098x123xxx (known 0987123, missing last 3 digits)
   Example: 0987?????5 (known start 0987 and end 5)
   Example: 09xxxxxxxx (only known 09)
   ```

## Optimization Tips

### Effective patterns:
- Avoid: `0888xxxxxx` (1 million combinations)
- Good: `0888123xxx` (1,000 combinations)
- Best: `088812345x` (10 combinations)

### Delay timing:
- Regular websites: 1-2 seconds
- Slow websites: 3-5 seconds
- Avoid blocking: ≥1 second

### Result count:
- Testing: 1-5 results
- Real usage: 10-50 results
- Large collection: 100+ results

## Usage Examples

### Example 1: Quick Test from GitHub
```bash
# Only test ChromeDriver, no input needed
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash
```

### Example 2: Interactive Mode from GitHub (RECOMMENDED)
```bash
# Download and open new terminal - BEST SOLUTION
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash

# Or manual setup
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/interactive.sh | bash
cd zal-bypass-interactive && python3 phone_search.py
```

### Example 3: Search specific phone number (Local)
```bash
python phone_search.py
```
```
Website URL: https://example.com/phonebook
Search box CSS selector: #phone-search
Results CSS selector: .search-results
Phone pattern: 098712345x
Target name: John Doe
Delay: 2
Max results: 1
Run headless: n
```

### Example 4: Using config file
```json
{
  "website_url": "https://example.com/search",
  "search_box_selector": "#search-input",
  "result_selector": ".search-results",
  "phone_pattern": "098712345x",
  "target_name": "John Doe",
  "delay": 2,
  "max_results": 1,
  "headless": false
}
```

## How to Find CSS Selector

1. **Open the website** you want to search
2. **Press F12** to open Developer Tools
3. **Press Ctrl+Shift+C** to activate inspect element
4. **Click on the search box** on the webpage
5. **Copy CSS selector**:
   - Right-click on the highlighted element
   - Select "Copy" > "Copy selector"

## Results

The program will create a `search_results.json` file containing:
```json
[
  {
    "phone_number": "0987123456",
    "result_text": "John Doe - 0987123456",
    "found_target": true,
    "timestamp": 1699123456.789
  }
]
```

## Important Notes

**Use responsibly**:
- Only use for legal purposes
- Follow website Terms of Service
- Don't spam or overload servers
- Set reasonable delay (≥1 second)

**Limitations**:
- Some websites have CAPTCHA or rate limiting
- May need proxy or IP rotation for large volumes
- Check website's robots.txt

## Troubleshooting

### "ChromeDriver not found" error
```bash
# Reinstall webdriver-manager
pip install --upgrade webdriver-manager
```

### "Element not found" error
- Check CSS selector again
- Try waiting longer for page to load
- Check if element is inside iframe

### "Timeout" error
- Increase delay time
- Check internet connection
- Try with different website

### Website blocking
- Increase delay between requests
- Use proxy
- Change User-Agent
- Run in headless mode

### stdin/input error when running remote scripts
```bash
# BEST SOLUTION: Use download_and_run.sh
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/download_and_run.sh | bash

# Or manual setup
curl -sSL https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/interactive.sh | bash
cd zal-bypass-interactive && python3 phone_search.py

# Or download locally
git clone https://github.com/nhatpm3124/zal-bypass.git
cd zal-bypass
python phone_search.py
```

### Error running remote scripts
```bash
# If curl doesn't work, try wget
wget -qO- https://raw.githubusercontent.com/nhatpm3124/zal-bypass/main/one_liner.sh | bash

# If permissions error
chmod +x script.sh
```

## Advanced Features

### Run with multiple patterns
```bash
# Create multiple config files
cp config_example.json config1.json
cp config_example.json config2.json
# Run in parallel
python run_with_config.py config1.json &
python run_with_config.py config2.json &
```

### Performance optimization
- Use headless mode: `"headless": true`
- Reduce delay: `"delay": 0.5`
- Increase max_results: `"max_results": 100`

### Deployment options
```bash
# Run on server
nohup python phone_search.py > output.log 2>&1 &

# Run with Docker (if Dockerfile exists)
docker run -it phone-search-tool

# Run with systemd service
sudo systemctl start phone-search
```

## Script Comparison

| Script | Purpose | Input Required | New Terminal | Suitable For |
|--------|---------|----------------|--------------|-------------|
| `one_liner.sh` | Quick ChromeDriver test | No | No | Quick demo |
| `download_and_run.sh` | **Full interactive** | **Yes** | **Yes** | **RECOMMENDED** |
| `interactive.sh` | Manual setup | Yes | No | Advanced users |
| `run_remote.sh` | Menu selection | Yes | No | Flexible |
| `install.sh` | Permanent install | Minimal | No | Long-term setup |

**Recommendation**: Use `download_and_run.sh` for best experience!

## Changelog

### v2.3 (Latest)
- Added `download_and_run.sh` - Perfect solution for stdin
- Automatic new terminal opening on macOS/Linux
- Improved user experience with remote execution
- Updated detailed documentation

## Contact

- GitHub Issues: Bug reports and feature requests
- Email: nhatpm.sg@gmail.com

## License

MIT License - See LICENSE file for details.

---

**ALL COPYRIGHT BELONG TO NHATPM.SG**
