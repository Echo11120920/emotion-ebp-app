#!/bin/bash
# Extract all CBT course content

BASE_DIR="$HOME/Downloads/暂停实验室_EBP/CBT综合"

# Define all the URLs to process
declare -a URLS=(
    "https://ebp.gesedna.com/EBPModule/ebp.guidevideo?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.read.0?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.commitment.00?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.2?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.3?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.4?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.5?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.6?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.7?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.8?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.9?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.10?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.11?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.12?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.13?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.14?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.15?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.16?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.17?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.18?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.19?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.20?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.21?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.22?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.23?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.24?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.25?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.26?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.write.27?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.clamdown?available=0&package_id=cbt_base"
    "https://ebp.gesedna.com/EBPModule/ebp.cbt.base.pdf?available=0&package_id=cbt_base"
)

# Download the main PDF template
echo "Downloading CBT writing template..."
curl -L -o "$BASE_DIR/Tools_书写模板下载/CBT综合_书写模板.pdf" \
    "https://static.gesedna.com/wp_uploads/2024/03/CBT%E7%BB%BC%E5%90%88%E7%BB%83%E4%B9%A0%E4%B9%A6%E5%86%99%E6%A8%A1%E6%9D%BF-%E6%9A%82%E5%81%9C%E5%AE%9E%E9%AA%8C%E5%AE%A4-2024.3.pdf"

echo "Setup complete. Use browser automation to extract content from each page."
