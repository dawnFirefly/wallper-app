<div align="center">

<br />

<img width="180" height="180" alt="Wallper App Icon" src="https://github.com/user-attachments/assets/ba9fd97a-3798-4d1a-bd6e-07f13555efa6" />

<br />

# Wallper

**Live 4K video wallpapers for macOS — seamless, silent, beautiful.**

<br />

<a href="https://wallper.app"><img alt="Website" src="https://img.shields.io/badge/wallper.app-000000.svg?style=for-the-badge&logo=safari&logoColor=white&labelColor=000"></a>
&nbsp;
<a href="https://github.com/alxndlk/wallper-app/releases/latest"><img alt="Download" src="https://img.shields.io/badge/Download_DMG-000000.svg?style=for-the-badge&logo=apple&logoColor=white&labelColor=000"></a>
&nbsp;
<a href="https://discord.gg/ksxrdnETuc"><img alt="Discord" src="https://img.shields.io/badge/Discord-7289da.svg?style=for-the-badge&logo=Discord&labelColor=000000&logoWidth=20"></a>
&nbsp;
<a href="https://github.com/alxndlk/wallper-app/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/alxndlk/wallper-app?style=for-the-badge&logo=Github&labelColor=000&color=white"></a>

<br />
<br />

*Turn your Mac into a living, breathing canvas.*

<br />

> **Wallper is closed-source proprietary software.**
> This repository hosts releases, documentation, and community resources.
> Source code is not publicly available.

<br />

</div>

---

## Table of Contents

- [✨ Features](#-features)
- [🎵 Music Sync](#-music-sync)
- [🏗 Architecture](#-architecture)
- [🛠 Tech Stack](#-tech-stack)
- [📦 Install](#-install)
- [🌐 Ecosystem](#-ecosystem)
- [🔒 Security](#-security)
- [📄 License](#-license)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎬 Video Wallpapers
- **2000+** curated wallpapers in the cloud library
- 4K / 60fps H.264 & H.265 playback
- Metal-optimized rendering pipeline
- Low-latency hardware decoding
- Seamless infinite looping
- Circular reveal animation on apply

</td>
<td width="50%">

### 🖥 Multi-Display
- Apply wallpapers to individual or all displays simultaneously
- Per-screen pan, zoom & transform controls
- Automatic restore on screen changes & Space switches
- Menu bar color adaptation via still-frame extraction
- Smart wallpaper persistence across reboots

</td>
</tr>
<tr>
<td width="50%">

### 🔍 Smart Library
- Filter by resolution, duration, file size, category & date
- Cloud-synced library with metadata & likes
- Intelligent search & category browsing
- Background downloads with progress tracking
- Efficient in-memory caching for instant scrolling
- Lazy batch loading (2000+ wallpapers, no lag)

</td>
<td width="50%">

### 🔐 Security & Updates
- macOS App Sandbox & Hardened Runtime
- Code Signing & Notarization
- Automatic update checking with smart retry
- License validation & multi-device management
- Battery-aware pause (stops on battery power)
- Apple Silicon native (M1/M2/M3/M4)

</td>
</tr>
</table>

---

## 🎵 Music Sync

Wallper reacts to your music in real time.

- **Apple Music & Spotify** — dual player support with automatic switching
- **Dynamic lockscreen** — album-colored gradient videos generated on the fly
- **Desktop background sync** — music-reactive gradients on macOS 14–15
- **Smart transitions** — smooth handoff between players, restores original wallpaper when paused
- **Lockscreen caching** — encoded videos cached to skip re-rendering on repeat plays
- **Mesh gradients** — GPU-efficient cursor-reactive gradient backgrounds with smooth lerp interpolation

---

## 🏗 Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                        Wallper · macOS App                        │
│                                                                  │
│  ┌───────────┐  ┌──────────────────┐  ┌───────────────────────┐ │
│  │  SwiftUI  │  │  Video Wallpaper │  │  Music Sync Engine    │ │
│  │  Frontend  │  │  Manager         │  │  Apple Music/Spotify  │ │
│  └─────┬─────┘  └────────┬─────────┘  └───────────┬───────────┘ │
│        │                 │                         │             │
│  ┌─────▼─────────────────▼─────────────────────────▼───────────┐ │
│  │  AVKit · Metal · CoreAnimation · CoreImage · CoreGraphics   │ │
│  │  Combine · AVPlayerLooper · CAShapeLayer · NSCache          │ │
│  └──────────────────────────┬──────────────────────────────────┘ │
│                             │                                    │
│  ┌──────────────────────────▼──────────────────────────────────┐ │
│  │  Licensing · Updates · Device Management · Power Monitor    │ │
│  └─────────────────────────────────────────────────────────────┘ │
└────────────────────────────────┬─────────────────────────────────┘
                                 │ HTTPS / JSON
┌────────────────────────────────▼─────────────────────────────────┐
│                        Cloud Infrastructure                      │
│                                                                  │
│  API Gateway ─▶ AWS Lambda (Node.js) ─▶ DynamoDB (metadata)     │
│                                                                  │
│  S3 / MinIO (video storage) ─▶ CloudFront CDN (global delivery) │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🛠 Tech Stack

| Layer | Technologies |
|:------|:-------------|
| **App** | Swift · SwiftUI · AVKit · Combine · CoreAnimation · Metal · CoreImage |
| **Backend** | AWS Lambda (Node.js) · API Gateway · DynamoDB · CloudFront |
| **Storage** | Amazon S3 · MinIO · NSCache · URLSession |
| **Infrastructure** | HTTPS · JSON APIs · GZIP · CORS · CDN |
| **DevOps** | GitHub Actions · Code Signing · Notarization · GitHub Releases |
| **Website** | [wallper.app](https://wallper.app) |

---

## 📦 Install

### Requirements

- **macOS** 13.0 (Ventura) or later
- Apple Silicon or Intel Mac

### Download

<div align="center">

<br />

**[⬇️ Download Wallper.dmg](https://github.com/alxndlk/wallper-app/releases/latest)**

<br />

</div>

1. Download `Wallper.dmg` from the [latest release](https://github.com/alxndlk/wallper-app/releases/latest)
2. Open the DMG and drag **Wallper** to Applications
3. Launch Wallper — it lives in your menu bar
4. Browse, pick a wallpaper, and enjoy ✨

> Wallper is code-signed and notarized by Apple. If macOS shows a warning, right-click → Open.

---

## 🌐 Ecosystem

Wallper is built by **[Sandimax](https://sandimax.com)** — an independent team crafting premium software.

| Product | Description | Link |
|:--------|:------------|:-----|
| **Wallper** | Live 4K video wallpapers for macOS | [wallper.app](https://wallper.app) |
| **Copier** | Smart clipboard manager | [trycopier.app](https://trycopier.app) |
| **Calendarly** | Calendar wallpaper for iOS | [getcalendarly.com](https://getcalendarly.com) |
| **Locora** | Travel companion with 50,000+ city guides | [locora.app](https://locora.app) |
| **Sandimax** | Team & portfolio | [sandimax.com](https://sandimax.com) |

---

## 🔒 Security

Found a vulnerability? Please report it responsibly — see [SECURITY.md](SECURITY.md) for details.

---

## 📄 License

**Wallper is proprietary software.** All rights reserved.
See [license.md](license.md) for the full license terms.

---

<div align="center">

<br />

**Built with ❤️ by [Sandimax](https://sandimax.com)**

<br />

<a href="https://wallper.app">🌐 Website</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/releases/latest">⬇️ Download</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://discord.gg/ksxrdnETuc">💬 Discord</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/issues">🐛 Report Bug</a>

<br />
<br />

</div>
