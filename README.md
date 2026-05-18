<div align="center">

<br />

<img width="180" height="180" alt="Wallper App Icon" src="https://github.com/user-attachments/assets/ba9fd97a-3798-4d1a-bd6e-07f13555efa6" />

<br />

# Wallper

**Stunning 4K video wallpapers for macOS — seamless, silent, beautiful.**

<br />

<a href="https://github.com/alxndlk"><img alt="Made by alxndlk" src="https://img.shields.io/badge/MADE%20BY%20alxndlk-000000.svg?style=for-the-badge&logo=Github&labelColor=000"></a>
&nbsp;
<a href="https://github.com/alxndlk/wallper-app/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/alxndlk/wallper-app?style=for-the-badge&logo=Github&labelColor=000&color=white"></a>
&nbsp;
<a href="license.md"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge&labelColor=000000"></a>
&nbsp;
<a href="https://discord.gg/ksxrdnETuc"><img alt="Discord" src="https://img.shields.io/badge/Discord-7289da.svg?style=for-the-badge&logo=Discord&labelColor=000000&logoWidth=20"></a>

<br />
<br />

*Turn your desktop into a living, breathing canvas.*

<br />

</div>

---

## Table of Contents

- [✨ Features](#-features)
- [🏗 Architecture](#-architecture)
- [🛠 Tech Stack](#-tech-stack)
- [📂 Project Structure](#-project-structure)
- [🚀 Getting Started](#-getting-started)
- [🤝 Contributing](#-contributing)
- [🔒 Security](#-security)
- [📄 License](#-license)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎬 Video Playback
- 4K / 60fps H.264 & H.265 video wallpapers
- Metal-optimized rendering pipeline
- Low-latency hardware decoding
- Seamless looping via `AVPlayerLooper`
- Circular reveal animation on apply

</td>
<td width="50%">

### 🖥 Multi-Display
- Apply wallpapers to individual or all displays
- Per-screen pan, zoom & transform controls
- Automatic restore on screen changes & Space switches
- Menu bar color adaptation via still-frame extraction

</td>
</tr>
<tr>
<td width="50%">

### 🔍 Smart Library
- Filter by resolution, duration, file size, category & date
- Cloud-synced video library with metadata
- Background downloads with `URLSession`
- Efficient in-memory caching via `NSCache`

</td>
<td width="50%">

### 🔐 Security & Updates
- macOS App Sandbox & Hardened Runtime
- Code Signing & Notarization
- Automatic update checking with retry logic
- License validation & device management

</td>
</tr>
</table>

---

## 🏗 Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                          macOS App                               │
│                                                                  │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────────────────┐ │
│  │  SwiftUI    │  │  AppDelegate │  │  LaunchBootstrapper     │ │
│  │  Interface  │──│  Lifecycle   │──│  Update · Ban · License │ │
│  └─────────────┘  └──────────────┘  └─────────────────────────┘ │
│         │                                       │                │
│  ┌──────▼──────────────────────────────────────▼──────────────┐ │
│  │              VideoWallpaperManager                         │ │
│  │  AVQueuePlayer · AVPlayerLooper · CAShapeLayer Animations  │ │
│  │  Multi-display · Pan/Zoom · Menu Bar Adaptation            │ │
│  └──────────────────────────┬─────────────────────────────────┘ │
│                             │                                    │
│  ┌──────────────────────────▼─────────────────────────────────┐ │
│  │  AVKit · Metal · CoreAnimation · CoreImage · CoreGraphics  │ │
│  └────────────────────────────────────────────────────────────┘ │
└────────────────────────────────┬─────────────────────────────────┘
                                 │ HTTPS / JSON
┌────────────────────────────────▼─────────────────────────────────┐
│                        AWS Backend                               │
│                                                                  │
│  API Gateway ─▶ Lambda (Node.js) ─▶ DynamoDB (metadata/likes)   │
│                                                                  │
│  S3 / MinIO (video storage) ─▶ CloudFront CDN (delivery)        │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🛠 Tech Stack

| Layer | Technologies |
|:------|:-------------|
| **Frontend** | SwiftUI · AVKit · Combine · CoreAnimation · Metal · CoreImage |
| **Backend** | AWS Lambda · API Gateway · S3 · MinIO · DynamoDB · CloudFront |
| **Build** | Xcode · Swift Package Manager · Shell scripts |
| **Infrastructure** | HTTPS · JSON APIs · GZIP compression · CORS |
| **DevOps** | GitHub Actions · macOS Code Signing · Notarization |

---

## 📂 Project Structure

```
wallper-app/
├── open-source-code/
│   ├── app-delegate.swift        # App lifecycle, notifications, power & screen monitoring
│   ├── launch.manager.swift      # Boot sequence: update check → ban check → ready
│   ├── launch.provider.swift     # License manager convenience extension
│   └── video.manager.swift       # Core wallpaper engine: playback, transforms, adaptation
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── SECURITY.md
├── license.md
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- **macOS** 13.0 (Ventura) or later
- **Xcode** 15+
- **Swift** 5.9+

### Explore the Source

```bash
# Clone the repository
git clone https://github.com/alxndlk/wallper-app.git
cd wallper-app
```

Browse the `open-source-code/` directory to study the core wallpaper engine, boot sequence, and app lifecycle management.

### Build Wallper on macOS

```bash
swift build
swift run wallper-app
```

> **Note:** This restored repository includes a minimal open-source scaffold so the app can compile and run on macOS while proprietary services/features remain stubbed.

---

## 🤝 Contributing

Contributions are welcome! Please read the [Contributing Guide](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md) before submitting a pull request.

---

## 🔒 Security

Found a vulnerability? Please report it responsibly — see [SECURITY.md](SECURITY.md) for details.

---

## 📄 License

This project is licensed under the **MIT License** — see the [license.md](license.md) file for details.

---

<div align="center">

<br />

**Built with ❤️ by [alxndlk](https://github.com/alxndlk)**

<br />

<a href="https://github.com/alxndlk/wallper-app/stargazers">⭐ Star this repo</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/issues">🐛 Report Bug</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://discord.gg/ksxrdnETuc">💬 Join Discord</a>

<br />
<br />

</div>
