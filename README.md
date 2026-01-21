# Personal Will Builder (最终余言)

一个简单易用的在线遗嘱生成工具，支持中英文双语。

## ✨ 新功能：iOS 支持

现在支持在 iPhone 上下载和打印遗嘱！

- ✅ 使用 iOS 系统分享面板
- ✅ 保存到 Files app
- ✅ 通过 AirPrint 打印
- ✅ 向后兼容桌面浏览器

## 🚀 快速开始（本地测试）

### 1. Clone 代码

```bash
git clone https://github.com/streetbird/personal-will-builder-web.git
cd personal-will-builder-web
git checkout claude/add-top-banner-Pq0CC
```

### 2. 启动本地服务器

```bash
./start-server.sh
```

或手动启动：

```bash
python3 -m http.server 8000
```

### 3. 在 iPhone 上测试

**选项 A：Xcode Simulator**
- 打开 Xcode Simulator
- 在 Safari 中访问 `http://localhost:8000`

**选项 B：真实 iPhone**
- 确保 Mac 和 iPhone 在同一 Wi-Fi
- 在 Safari 中访问 `http://你的IP:8000`
- 脚本会自动显示 IP 地址

## 📖 详细测试指南

查看 [LOCAL_TESTING.md](./LOCAL_TESTING.md) 获取完整的测试说明。

## 🌐 在线访问

网站地址：[www.lastyuyan.com](http://www.lastyuyan.com)

## 📱 功能特性

- 📝 简单的表单填写流程
- 🌍 中英文双语支持
- 💾 下载为 TXT 文件
- 🖨️ 打印功能
- 📱 完整的 iOS 支持
- 🔒 隐私保护（所有数据仅在浏览器本地处理）

## 🛠️ 技术栈

- React 19.2.3
- Tailwind CSS
- Parcel (构建工具)
- Web Share API (iOS 支持)

## 📄 License

MIT
