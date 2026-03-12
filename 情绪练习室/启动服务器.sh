#!/bin/bash

# 启动本地HTTP服务器运行App

cd "/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/情绪练习室-柔和粉"

echo "启动HTTP服务器..."
echo "请在浏览器中访问: http://localhost:8080"
echo ""
echo "按 Ctrl+C 停止服务器"
echo ""

python3 -m http.server 8080