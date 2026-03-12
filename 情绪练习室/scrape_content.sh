#!/bin/bash

# 抓取所有阅读页面的文字内容

CONTENT_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/content"
mkdir -p "$CONTENT_DIR"

echo "开始抓取阅读内容..."

# 使用浏览器抓取内容的Node.js脚本
cat > /tmp/scrape_content.js << 'EOF'
const fs = require('fs');

// 模拟抓取（实际需要在浏览器中运行）
const days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];

console.log('需要抓取的阅读页面:');
days.forEach(day => {
  console.log(`Day ${day}: https://ebp.gesedna.com/EBPModule/ebp.emotion.base.read.${day}`);
});
EOF

node /tmp/scrape_content.js

echo ""
echo "由于浏览器限制，我将使用curl抓取页面HTML，然后提取文字内容..."

# 抓取Day 1作为示例
curl -s "https://ebp.gesedna.com/EBPModule/ebp.emotion.base.read.1?available=0&package_id=emotion_base" \
  -H "User-Agent: Mozilla/5.0" \
  -H "Cookie: 需要登录cookie" > "$CONTENT_DIR/day01_read.html"

if [ -f "$CONTENT_DIR/day01_read.html" ]; then
  size=$(stat -f%z "$CONTENT_DIR/day01_read.html" 2>/dev/null)
  echo "Day 1 HTML已下载: ${size} bytes"
fi

echo ""
echo "说明：由于需要登录状态，直接curl无法获取完整内容。"
echo "建议方案：使用浏览器访问每个页面，复制文字内容保存为Markdown文件。"