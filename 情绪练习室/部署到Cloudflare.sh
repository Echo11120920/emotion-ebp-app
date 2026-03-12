#!/bin/bash

# Cloudflare Pages 一键部署脚本
# 情绪练习室 - 情绪EBP 28天打卡App

echo "========================================"
echo "  情绪练习室 - Cloudflare Pages 部署脚本"
echo "========================================"
echo ""

# 检查是否安装了 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ 错误：需要安装 Node.js"
    echo "请访问 https://nodejs.org 下载安装"
    exit 1
fi

echo "✓ Node.js 已安装"

# 检查是否安装了 Wrangler（Cloudflare CLI）
if ! command -v wrangler &> /dev/null; then
    echo ""
    echo "正在安装 Cloudflare Wrangler CLI..."
    npm install -g wrangler
fi

echo "✓ Wrangler CLI 已安装"

# 项目路径
PROJECT_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/情绪练习室-上传版"

echo ""
echo "项目路径: $PROJECT_DIR"
echo ""

# 检查项目目录是否存在
if [ ! -d "$PROJECT_DIR" ]; then
    echo "❌ 错误：项目目录不存在"
    echo "请确认路径正确"
    exit 1
fi

echo "✓ 项目目录存在"
echo ""

# 进入项目目录
cd "$PROJECT_DIR"

# 登录 Cloudflare
echo "步骤1: 登录 Cloudflare"
echo "------------------------"
echo "这将打开浏览器让你登录 Cloudflare 账号"
echo ""
wrangler login

echo ""
echo "步骤2: 部署到 Cloudflare Pages"
echo "------------------------"
echo ""

# 部署
wrangler pages deploy . --project-name=emotion-ebp-app

echo ""
echo "========================================"
echo "  部署完成！"
echo "========================================"
echo ""
echo "你的网站地址:"
echo "https://emotion-ebp-app.pages.dev"
echo ""
echo "如果网址被占用，请修改 project-name"
echo ""
echo "如需更新网站，重新运行此脚本即可"
echo ""

read -p "按回车键退出..."