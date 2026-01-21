# 本地测试指南

## 如何在 iPhone 上测试 Web 应用

这是一个 Web 应用（不是原生 iOS app），可以通过以下几种方式在 iPhone 上测试：

---

## 方法 1：使用 Xcode Simulator（推荐用于快速测试）

### 步骤：

1. **Clone 代码到本地**
   ```bash
   git clone https://github.com/streetbird/personal-will-builder-web.git
   cd personal-will-builder-web
   git checkout claude/add-top-banner-Pq0CC
   ```

2. **启动本地 HTTP 服务器**

   选择以下任一方式：

   **方式 A - Python（推荐，macOS 自带）**
   ```bash
   # Python 3
   python3 -m http.server 8000

   # 或 Python 2
   python -m SimpleHTTPServer 8000
   ```

   **方式 B - Node.js（如果已安装）**
   ```bash
   npx http-server -p 8000
   ```

   **方式 C - PHP（macOS 自带）**
   ```bash
   php -S localhost:8000
   ```

3. **在 Xcode Simulator 中测试**
   - 打开 Xcode
   - 选择 `Xcode` → `Open Developer Tool` → `Simulator`
   - 选择 iPhone 机型（如 iPhone 15 Pro）
   - 在 Simulator 中打开 **Safari** 浏览器
   - 访问地址：`http://localhost:8000`
   - 测试下载和打印功能

---

## 方法 2：使用真实 iPhone 通过局域网访问（推荐用于真实测试）

### 步骤：

1. **启动本地服务器（同方法 1 步骤 2）**

2. **获取你的 Mac 的 IP 地址**
   ```bash
   # 方法 1：命令行
   ifconfig | grep "inet " | grep -v 127.0.0.1

   # 方法 2：系统设置
   # 打开：系统设置 → 网络 → Wi-Fi → 详细信息
   # 找到 IP 地址，例如：192.168.1.100
   ```

3. **在 iPhone 上访问**
   - 确保 iPhone 和 Mac 连接到**同一个 Wi-Fi**
   - 在 iPhone Safari 中访问：`http://你的IP地址:8000`
   - 例如：`http://192.168.1.100:8000`
   - 测试下载和打印功能

**注意**：如果无法访问，可能需要临时关闭 Mac 防火墙：
- 系统设置 → 网络 → 防火墙 → 暂时关闭

---

## 方法 3：部署到 GitHub Pages（推荐用于长期测试）

### 步骤：

1. **合并到 main 分支**
   ```bash
   # 在 GitHub 上创建 Pull Request
   # 或直接合并
   git checkout main
   git merge claude/add-top-banner-Pq0CC
   git push origin main
   ```

2. **等待 GitHub Pages 自动部署**（约 1-2 分钟）

3. **访问网站**
   - 根据 CNAME 文件，应该是：`http://www.lastyuyan.com`
   - 或 GitHub Pages 默认地址：`https://streetbird.github.io/personal-will-builder-web`

4. **在 iPhone 上测试**
   - 直接在 Safari 中访问部署的网站
   - 测试下载和打印功能

---

## 测试检查清单

在 iPhone Safari 中测试以下功能：

### ✅ 下载功能测试
1. 填写完整的遗嘱信息
2. 到达预览页面
3. 点击 **Download TXT** 按钮
4. **期望结果**：
   - ✓ 弹出 iOS 系统分享面板（Share Sheet）
   - ✓ 可以看到"存储到文件"选项
   - ✓ 可以看到"打印"选项
   - ✓ 选择"存储到文件"后，文件成功保存到 Files app

### ✅ 打印功能测试
1. 在预览页面点击 **Print Will** 按钮
2. **期望结果**：
   - ✓ 弹出 iOS 系统分享面板（Share Sheet）
   - ✓ 可以看到"打印"选项
   - ✓ 选择打印后，进入 iOS 打印预览界面
   - ✓ 可以看到 AirPrint 打印选项

### ✅ Fallback 测试（桌面浏览器）
1. 在 Mac Safari 或 Chrome 中测试
2. 点击下载按钮
3. **期望结果**：
   - ✓ 直接下载 TXT 文件（不弹出分享面板）
4. 点击打印按钮
5. **期望结果**：
   - ✓ 弹出浏览器打印对话框

---

## 调试提示

### 如果在 Simulator 中无法弹出 Share Sheet：
- 这是正常的，Simulator 的 Web Share API 支持可能有限
- **建议使用真实 iPhone 测试**（方法 2）

### 如果在真实 iPhone 上无法弹出 Share Sheet：
1. 检查 Safari 版本（需要 iOS 12.2+）
2. 打开 Safari 开发者工具：
   - Mac Safari：`开发` → `你的iPhone` → `网页检查器`
   - 查看 Console 是否有错误信息

### 查看日志：
在代码中已经添加了错误日志：
```javascript
console.log("Share failed:", err)
```

可以在 Safari 开发者工具的 Console 中查看。

---

## 快速启动脚本

为了方便，可以使用这个一键启动脚本：

```bash
#!/bin/bash
# 文件名：start-server.sh

echo "🚀 启动本地服务器..."
echo ""
echo "📱 本地访问地址："
echo "   http://localhost:8000"
echo ""
echo "📱 局域网访问地址（用于真实 iPhone）："
LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)
echo "   http://$LOCAL_IP:8000"
echo ""
echo "按 Ctrl+C 停止服务器"
echo ""

python3 -m http.server 8000
```

使用方法：
```bash
chmod +x start-server.sh
./start-server.sh
```

---

## 技术说明

### Web Share API 支持情况：
- ✅ iOS Safari 12.2+
- ✅ iPadOS Safari 13+
- ✅ Android Chrome 75+
- ❌ Desktop Safari（不支持）
- ❌ Desktop Chrome（不支持）

### Fallback 行为：
- 桌面浏览器会自动回退到原有的下载/打印方式
- 用户体验不受影响

---

## 需要帮助？

如果遇到问题，请检查：
1. Mac 和 iPhone 是否在同一 Wi-Fi 网络
2. Mac 防火墙是否阻止了连接
3. iPhone Safari 版本是否 12.2+
4. 浏览器 Console 中是否有错误信息
