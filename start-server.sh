#!/bin/bash

# 本地测试服务器启动脚本

echo "🚀 启动 Personal Will Builder 本地服务器..."
echo ""

# 获取本机局域网 IP
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    LOCAL_IP=$(hostname -I | awk '{print $1}')
else
    LOCAL_IP="无法自动获取"
fi

echo "📱 访问地址："
echo ""
echo "   本地访问（Xcode Simulator）:"
echo "   http://localhost:8000"
echo ""
echo "   局域网访问（真实 iPhone）:"
echo "   http://$LOCAL_IP:8000"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 测试步骤："
echo "   1. 在 iPhone Safari 中打开上面的地址"
echo "   2. 填写遗嘱信息并到达预览页面"
echo "   3. 点击 Download 或 Print 按钮"
echo "   4. 应该会弹出 iOS 分享面板"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "ℹ️  当前分支: $(git branch --show-current)"
echo ""
echo "⏹  按 Ctrl+C 停止服务器"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 检查 Python 版本并启动服务器
if command -v python3 &> /dev/null; then
    echo "✓ 使用 Python 3 启动服务器"
    echo ""
    python3 -m http.server 8000
elif command -v python &> /dev/null; then
    echo "✓ 使用 Python 2 启动服务器"
    echo ""
    python -m SimpleHTTPServer 8000
elif command -v php &> /dev/null; then
    echo "✓ 使用 PHP 启动服务器"
    echo ""
    php -S 0.0.0.0:8000
else
    echo "❌ 错误: 未找到 Python 或 PHP"
    echo ""
    echo "请安装 Python 或使用以下命令："
    echo "  npx http-server -p 8000"
    exit 1
fi
