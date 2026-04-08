<div align="center">

<br />

<img width="180" height="180" alt="Wallper App Icon" src="https://github.com/user-attachments/assets/ba9fd97a-3798-4d1a-bd6e-07f13555efa6" />

<br />

# Wallper

**Live 4K video wallpapers for macOS — seamless, silent, beautiful.**

Bring your desktop to life with stunning dynamic wallpapers. Seamless performance, elegant control, and effortless customization — all in one place.

<br />

<a href="https://wallper.app"><img alt="Website" src="https://img.shields.io/badge/wallper.app-000000.svg?style=for-the-badge&logo=safari&logoColor=white&labelColor=000"></a>
&nbsp;
<a href="https://github.com/alxndlk/wallper-app/releases/latest"><img alt="Download" src="https://img.shields.io/badge/Download_DMG-000000.svg?style=for-the-badge&logo=apple&logoColor=white&labelColor=000"></a>
&nbsp;
<a href="https://discord.gg/ksxrdnETuc"><img alt="Discord" src="https://img.shields.io/badge/Discord-7289da.svg?style=for-the-badge&logo=Discord&labelColor=000000&logoWidth=20"></a>
&nbsp;
<a href="https://github.com/alxndlk/wallper-app/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/alxndlk/wallper-app?style=for-the-badge&logo=Github&labelColor=000&color=white"></a>
&nbsp;
<a href="https://github.com/alxndlk/wallper-app/releases"><img alt="Version" src="https://img.shields.io/github/v/release/alxndlk/wallper-app?style=for-the-badge&logo=github&labelColor=000&color=white"></a>

<br />
<br />

*Turn your Mac into a living, breathing canvas.*

<br />

> **Wallper is closed-source proprietary software.**
> This repository hosts releases, documentation, and community resources.
> Source code is not publicly available.

<br />

<img width="100%" alt="Wallper App Preview" src="https://raw.githubusercontent.com/alxndlk/sandimax-site/master/public/wallper/wallper-bg.png" />

<br />

</div>

---

## Table of Contents

- [✨ Features](#-features)
- [🖼 Screenshots](#-screenshots)
- [🎬 Video Wallpapers](#-video-wallpapers)
- [🎵 Music Sync](#-music-sync)
- [🖥 Multi-Display & Display Manager](#-multi-display--display-manager)
- [🔒 Lock Screen & Screen Saver](#-lock-screen--screen-saver)
- [⚡ Smart Power Management](#-smart-power-management)
- [🎛 Playback Controls](#-playback-controls)
- [🔀 Shuffle Mode](#-shuffle-mode)
- [🌍 Localization](#-localization)
- [🏗 Architecture](#-architecture)
- [🛠 Tech Stack](#-tech-stack)
- [📦 Install](#-install)
- [🆕 What's New](#-whats-new)
- [🌐 Ecosystem](#-ecosystem)
- [❓ FAQ](#-faq)
- [💬 Community](#-community)
- [🔒 Security](#-security)
- [📄 License](#-license)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎬 Video Wallpapers
- **2,000+** curated 4K wallpapers in the cloud library
- 4K / 60fps H.264 & H.265 playback
- Metal-optimized rendering pipeline
- Low-latency hardware decoding
- Seamless infinite looping via `AVPlayerLooper`
- Circular reveal animation on apply
- Upload your own videos to the community library
- Like, save, and organize wallpapers in My Media

</td>
<td width="50%">

### 🖥 Multi-Display
- Apply wallpapers to individual or all displays simultaneously
- Per-screen pan, zoom & transform controls
- Automatic restore on screen changes & Space switches
- Menu bar color adaptation via still-frame extraction
- Smart wallpaper persistence across reboots
- Independent wallpaper per monitor
- Per-display pause & video switching

</td>
</tr>
<tr>
<td width="50%">

### 🔍 Smart Library
- Filter by resolution, duration, file size, category & date
- Sort wallpapers by multiple criteria
- Cloud-synced library with metadata & likes
- Intelligent search across wallpapers, tags & colors
- Background downloads with progress tracking
- Efficient in-memory caching for instant scrolling
- Lazy batch loading (2,000+ wallpapers, no lag)
- "Recommended For You" & "Recently Created" sections

</td>
<td width="50%">

### 🔐 Security & Updates
- macOS App Sandbox & Hardened Runtime
- Code Signed & Notarized by Apple
- Automatic update checking with smart retry
- Silent background updates
- License validation & multi-device management
- Battery-aware pause (stops on battery power)
- Apple Silicon native (M1/M2/M3/M4)
- App size optimized to just ~27 MB

</td>
</tr>
<tr>
<td width="50%">

### 🎵 Music Sync
- Apple Music & Spotify dual player support
- Album-colored dynamic lockscreen gradients
- Cursor-reactive mesh gradient backgrounds
- Real-time playback controls in menu bar
- Automatic switching between music players
- Lockscreen video caching for instant replays

</td>
<td width="50%">

### 🖼 Lock Screen & Screen Saver
- Native lock screen wallpapers (macOS 26+)
- Custom screen saver with your chosen video
- HEVC 10-bit transcoding for lock screen compatibility
- Automatic lock screen restore after unlock
- Stable across multiple lock/unlock cycles

</td>
</tr>
</table>

---

## 🖼 Screenshots

<div align="center">

<table>
<tr>
<td align="center"><b>🖥 Wallpaper Settings Integration</b></td>
<td align="center"><b>📱 Device Manager</b></td>
</tr>
<tr>
<td><img width="450" alt="Wallper in macOS Wallpaper Settings" src="https://github.com/user-attachments/assets/cb9dd6ac-a773-4f59-81cc-00af377b0496" /></td>
<td><img width="450" alt="Device Manager showing Mac Studio M4 Max" src="https://github.com/user-attachments/assets/703e7035-533c-4e7b-afa0-fddc06afd156" /></td>
</tr>
<tr>
<td align="center"><b>🔒 Lock Screen Setup</b></td>
<td align="center"><b>⚙️ Cache & Settings</b></td>
</tr>
<tr>
<td><img width="450" alt="Wallper Lock Screen configuration" src="https://github.com/user-attachments/assets/6778193b-857a-433d-bd93-574aaa898807" /></td>
<td><img width="450" alt="Settings panel with cache management" src="https://github.com/user-attachments/assets/f6ebaa5c-3009-44e5-8204-7cc2edb5f217" /></td>
</tr>
</table>

</div>

---

## 🎬 Video Wallpapers

Wallper turns your macOS desktop into a living canvas with **2,000+** curated 4K video wallpapers.

### How It Works

1. **Browse** — Explore the cloud library with smart filters: resolution, duration, file size, category, color, and date
2. **Preview** — Hover to see animated previews, generated server-side and cached locally
3. **Apply** — One click to download and set as wallpaper with a smooth circular reveal animation
4. **Enjoy** — Seamless infinite loop, zero flicker, Metal-optimized rendering

### Video Engine

The core playback engine has been rewritten from scratch for maximum performance:

- **Metal rendering pipeline** — hardware-accelerated video compositing with minimal GPU overhead
- **AVPlayerLooper** — seamless looping without visible cuts or delays
- **Hardware decoding** — H.264 and H.265 (HEVC) decoded on the video engine, not the CPU
- **Retina rendering toggle** — optional hi-DPI rendering, or reduce GPU load on older Macs
- **Smart quality presets** — Auto, High, Balanced, or Performance modes
- **Maximum resolution & frame rate limits** — fine-grained control over resource usage
- **contentsScale-based quality** — dynamic resolution scaling per display

### Community Uploads

You can upload your own video wallpapers to the Wallper library:

- Upload multiple videos at once
- Automatic color and type detection
- Backend-driven preview generation
- Creator name attribution displayed in the app
- Videos reviewed and published to the global library

---

## 🎵 Music Sync

> *Your wallpaper follows the music.*

Wallper reacts to your music in real time, syncing your desktop and lock screen to the currently playing track.

### Supported Players

| Player | Desktop Sync | Lock Screen Sync | Controls |
|:-------|:-------------|:-----------------|:---------|
| **Apple Music** | ✅ | ✅ | Play/Pause, Next, Previous |
| **Spotify** | ✅ | ✅ | Play/Pause, Next, Previous |

### How Music Sync Works

1. **Color extraction** — Album artwork is analyzed using advanced **k-means++ clustering** for accurate palette extraction
2. **Spatial arrangement** — Colors are spatially arranged to preserve the visual structure of the album cover
3. **Mesh gradient** — A GPU-efficient animated mesh gradient with organic blob motion reacts to your cursor position
4. **Lock screen video** — A seamlessly looping gradient video is rendered in HEVC and applied as the lock screen wallpaper
5. **Desktop background** — On macOS 14–15 (without lock screen API), a 4K gradient image is rendered from album colors and applied as desktop wallpaper

### Dual Player Support

- Apple Music and Spotify can play simultaneously
- When one player pauses, wallpaper automatically switches to the other active player
- When both players are paused, original wallpaper and lock screen are restored
- Active player state tracked in real-time via system notifications
- Debounced pause handling (400ms) prevents rapid flickers

### Performance

- Artwork cached in memory — returning to a previously played album skips the download
- Lock screen video rendered at optimized 720p/24fps — visually identical to full resolution, much faster
- Lockscreen video caching — three-tier install pipeline:
  - **Fast path:** same video already applied → skip
  - **Cache path:** transcoded file already in cache → apply immediately
  - **Slow path:** full download + HEVC transcode → apply
- Mesh gradient timer at 20fps (reduced from 30fps) — 33% less CPU, visually identical
- Cached blended colors — zero heap allocations when not transitioning between tracks
- Cursor tracking via direct `NSEvent.mouseLocation` polling — zero additional callbacks
- Smooth lerp interpolation for cursor-reactive gradients

---

## 🖥 Multi-Display & Display Manager

Wallper fully supports multi-monitor setups with independent per-display control.

### Display Manager Features

- **Per-display wallpaper** — set different wallpapers on each monitor
- **Scale control** — adjust wallpaper scale per screen
- **Position control** — fine-tune X/Y offset for each display
- **Disable per monitor** — turn off wallpapers on specific displays
- **Auto-center** — wallpapers auto-center on each screen, optimized for ultrawide and multi-display setups

### Menu Bar Integration

- Wallper lives in your menu bar — always accessible, never in the way
- **Current wallpaper name** always displayed correctly
- **Per-display pause & video switching** directly from the menu bar
- **Like wallpapers** directly from the menu bar
- **Open Shuffle** from the menu bar
- **Cache clearing** directly from the menu bar
- **CPU and RAM monitoring** — live system stats visible at a glance
- **App version** displayed in the menu bar view

### Smart Behavior

- Menu bar color adapts to match the wallpaper — a still frame is extracted and used to tint the system menu bar
- Wallpapers automatically restore after sleep, wake, unlock, screen changes, and Space switches
- Multi-monitor wallpaper save/restore — each screen's wallpaper is tracked and restored individually
- Smart window memory — the app remembers window positions and states across launches

---

## 🔒 Lock Screen & Screen Saver

### Lock Screen (macOS 26+)

- Set any Wallper video as your lock screen wallpaper
- Native macOS integration — appears in System Settings → Wallpapers
- HEVC 10-bit full transcode ensures consistent playback
- Automatic restore after unlock
- Stable across multiple lock/unlock cycles
- Toggle lock screen sync on/off in Settings → Music Sync

### Screen Saver

- **First truly native video screen saver for macOS**
- Apple notarized for security and compatibility
- No administrator rights required
- Extremely low resource usage
- Works independently of the Wallper app
- Videos automatically converted to `.mov` with HEVC encoding

### macOS Compatibility

| Feature | macOS 13–15 | macOS 26+ |
|:--------|:------------|:----------|
| Desktop wallpaper | ✅ | ✅ |
| Lock screen | ❌ | ✅ Native |
| Screen saver | Partial | ✅ Full |
| Music desktop sync | ✅ (gradient image) | ✅ (gradient video) |

---

## ⚡ Smart Power Management

Wallper is designed to be invisible when you need your Mac's full performance.

### Automatic Pausing

| Condition | Behavior |
|:----------|:---------|
| **On battery** | Wallpapers automatically pause, resume when plugged in |
| **Fullscreen app** | Wallpapers pause when any app goes fullscreen |
| **High CPU** | Wallpapers pause when CPU usage exceeds 80% |
| **Sleep/Wake** | Wallpapers properly restore after wake |
| **Manual pause** | Won't auto-resume if you manually paused |

### System Monitors

- **FullscreenMonitor** — detects fullscreen apps via workspace notifications and pauses wallpapers
- **CPUMonitor** — monitors system load and pauses when CPU > 80%
- **PowerMonitor** — tracks battery vs. AC power state
- Smart debouncing to prevent false triggers
- State persistence across app restarts

### Quality Scaling

- **Auto quality preset** — dynamically adjusts based on system resources
- **Battery quality reduction** — automatically lowers quality on battery power
- **Retina rendering toggle** — disable hi-DPI rendering to cut GPU load
- **Maximum resolution** and **frame rate limits** configurable per user
- `contentsScale`-based rendering lets the hardware decoder handle quality

---

## 🎛 Playback Controls

### Settings → Playback Tab

| Setting | Description |
|:--------|:------------|
| **Video Quality Preset** | Auto, High, Balanced, Performance |
| **Maximum Resolution** | Limit the maximum video resolution |
| **Frame Rate Limit** | Cap playback frame rate |
| **Video Volume** | Slider with real-time preview |
| **Video Speed** | Playback speed adjustment (per display) |
| **Transition Duration** | Control cross-fade between wallpapers |
| **Start Delay** | Delay before wallpaper begins playing |

All settings apply instantly — no reload, no flicker.

### Bottom Control Panel

- Pause / switch wallpapers instantly
- Set wallpapers per display
- Toggle lock screen wallpaper
- Like wallpapers directly from the panel
- Track info and playback controls for music sync

---

## 🔀 Shuffle Mode

Automatically rotate through your wallpaper collection.

- **Shuffle sources:** Liked wallpapers, Downloaded wallpapers, or both
- **Switch interval:** configurable timer for automatic rotation
- **Seamless switching** — smooth transitions between wallpapers
- **Optional lock screen inclusion** — shuffle applies to lock screen too (macOS 26+)
- Accessible directly from the menu bar

---

## 🌍 Localization

Wallper is available in **10 languages**:

<table>
<tr>
<td>🇺🇸 English</td>
<td>🇨🇳 Chinese</td>
<td>🇷🇺 Russian</td>
<td>🇫🇷 French</td>
<td>🇮🇹 Italian</td>
</tr>
<tr>
<td>🇪🇸 Spanish</td>
<td>🇺🇦 Ukrainian</td>
<td>🇯🇵 Japanese</td>
<td>🇰🇷 Korean</td>
<td>🇩🇪 German</td>
</tr>
</table>

---

## 🏗 Architecture

Wallper is a native macOS application with a cloud backend. The app communicates with the backend over HTTPS/JSON, and all video content is delivered via a global CDN.

### Client Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                          Wallper · macOS App                          │
│                                                                      │
│  ┌─────────────┐  ┌─────────────────┐  ┌──────────────────────────┐ │
│  │   SwiftUI   │  │ Video Wallpaper │  │   Music Sync Engine      │ │
│  │  Interface   │  │    Manager      │  │  Apple Music · Spotify   │ │
│  └──────┬──────┘  └───────┬─────────┘  └────────────┬─────────────┘ │
│         │                 │                          │               │
│  ┌──────▼─────────────────▼──────────────────────────▼─────────────┐ │
│  │  AVKit · Metal · CoreAnimation · CoreImage · CoreGraphics       │ │
│  │  Combine · AVPlayerLooper · CAShapeLayer · NSCache              │ │
│  │  AVFoundation · VideoToolbox (HEVC encoding)                    │ │
│  └──────────────────────────┬──────────────────────────────────────┘ │
│                             │                                        │
│  ┌──────────────────────────▼──────────────────────────────────────┐ │
│  │  System Integration Layer                                       │ │
│  │  ├── FullscreenMonitor    (workspace notifications)             │ │
│  │  ├── CPUMonitor           (load-based pause)                    │ │
│  │  ├── PowerMonitor         (battery-aware pause)                 │ │
│  │  ├── ScreenMonitor        (display change detection)            │ │
│  │  ├── LaunchBootstrapper   (update → ban → license → ready)     │ │
│  │  └── SMAppService         (Launch at Login)                     │ │
│  └─────────────────────────────────────────────────────────────────┘ │
└────────────────────────────────┬─────────────────────────────────────┘
                                 │
                            HTTPS / JSON
                                 │
┌────────────────────────────────▼─────────────────────────────────────┐
│                        Cloud Infrastructure                          │
│                                                                      │
│  ┌──────────┐    ┌──────────────┐    ┌────────────────────────────┐ │
│  │   API    │───▶│  AWS Lambda  │───▶│   DynamoDB                 │ │
│  │ Gateway  │    │  (Node.js)   │    │   (metadata, likes, users) │ │
│  └──────────┘    └──────────────┘    └────────────────────────────┘ │
│                                                                      │
│  ┌──────────────────┐    ┌───────────────────────────────────────┐  │
│  │  S3 / MinIO      │───▶│  CloudFront CDN                       │  │
│  │ (video storage)  │    │  (global delivery, GZIP, CORS)        │  │
│  └──────────────────┘    └───────────────────────────────────────┘  │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │  Backend Services                                            │   │
│  │  ├── Video library generation (server-side, not client)      │   │
│  │  ├── Preview generation (backend-rendered thumbnails)        │   │
│  │  ├── Upload processing (metadata validation, color detect)   │   │
│  │  ├── License validation & device management                  │   │
│  │  └── Update & ban checking                                   │   │
│  └──────────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────┘
```

### Key Design Decisions

- **Server-side library generation** — the video list is generated on the backend and sent ready-to-use, removing the old 1,000-video ceiling and reducing client load
- **Backend-rendered previews** — thumbnails are generated server-side and cached, not computed on the client
- **Three-tier caching** — NSCache (memory) → URLSession disk cache → CDN (network)
- **Offline-first** — downloaded wallpapers load instantly on boot without internet; library reloads automatically when connection returns
- **KVO-based settings** — replaced broad `UserDefaults.didChangeNotification` with targeted KVO on specific keys

---

## 🛠 Tech Stack

| Layer | Technologies |
|:------|:-------------|
| **App** | Swift · SwiftUI · AVKit · AVFoundation · Combine · CoreAnimation · Metal · CoreImage · CoreGraphics · VideoToolbox |
| **System** | SMAppService · NSWorkspace · NSEvent · CGWindowList · IOKit (power) |
| **Backend** | AWS Lambda (Node.js) · API Gateway · DynamoDB · CloudFront |
| **Storage** | Amazon S3 · MinIO · NSCache · URLSession · FileManager |
| **Encoding** | H.264 · H.265 (HEVC 10-bit) · VideoToolbox · `.mov` / `.mp4` |
| **Infrastructure** | HTTPS · JSON APIs · GZIP compression · CORS · CDN |
| **DevOps** | GitHub Actions · macOS Code Signing · Notarization · GitHub Releases |
| **Payments** | Stripe (one-time purchase, auto-refund within 14 days) |
| **Website** | [wallper.app](https://wallper.app) — Next.js · TypeScript · Vercel |
| **Community** | [Discord](https://discord.gg/ksxrdnETuc) · [Reddit](https://www.reddit.com/r/Sandimax/) · [GitHub Issues](https://github.com/alxndlk/wallper-app/issues) |

---

## 📦 Install

### Requirements

| Requirement | Minimum |
|:------------|:--------|
| **macOS** | 13.0 (Ventura) or later |
| **Processor** | Apple Silicon (M1/M2/M3/M4) or Intel |
| **Disk space** | ~27 MB for the app |
| **Internet** | Required for library browsing; offline playback after download |

### Download

<div align="center">

<br />

**[⬇️ Download Wallper.dmg](https://github.com/alxndlk/wallper-app/releases/latest)**

*Current version: **v1.6.6** — [View all releases](https://github.com/alxndlk/wallper-app/releases)*

<br />

</div>

### Installation Steps

1. Download `Wallper.dmg` from the [latest release](https://github.com/alxndlk/wallper-app/releases/latest)
2. Open the DMG and drag **Wallper** to your Applications folder
3. Launch Wallper — it lives in your **menu bar** ☝️
4. On first launch, the app will ask if you want to start at login
5. Browse the library, pick a wallpaper, and click **Set as Wallpaper**
6. Enjoy your living desktop ✨

> **Note:** Wallper is code-signed and notarized by Apple. If macOS shows a Gatekeeper warning, right-click the app → Open.

### Uninstall

1. Quit Wallper from the menu bar
2. Drag Wallper from Applications to Trash
3. Optionally clear cache: `~/Library/Caches/com.sandimax.wallper`

---

## 🆕 What's New

### v1.6.6 — Performance & UI Polish *(April 2026)*

- Explore page now loads in batches as you scroll (no more rendering 2,000+ at once)
- Tab switching is significantly snappier — content released from memory on leave
- Wallpaper name in menu bar now always displays correctly
- Close buttons throughout the app are easier to click (full area clickable)
- Prepared codebase for future Steam distribution

### v1.6.3 — Dual Player & Desktop Sync *(March 2026)*

- Apple Music + Spotify simultaneous support with automatic switching
- Desktop background sync — music-reactive 4K gradient on macOS 14–15
- Three-tier lockscreen caching pipeline (fast → cache → slow)
- Debounced pause handling prevents cascading lockscreen renders

### v1.6.1 — Music-Reactive Wallpapers *(March 2026)*

- Album-colored animated mesh gradient with organic blob motion
- k-means++ color clustering from album artwork
- Lockscreen video sync (macOS 26+)
- Playback controls in dock and menu bar

### v1.6.0 — 50K Users Milestone *(March 2026)*

- 🎉 **50,000 active users!**
- Fixed lock screen black screen after unlock/re-lock (6-month bug)
- Offline startup — wallpapers load instantly without internet
- All trials reset as community thank-you gift

### v1.5.0 — Playback Settings & Power Management *(January 2026)*

- New Playback Settings tab (quality, resolution, frame rate, volume, speed, transitions)
- FullscreenMonitor, CPUMonitor — wallpapers pause intelligently
- All settings apply instantly without reload

### v1.4.0 — Major UI Overhaul *(January 2026)*

- Completely redesigned Menu Bar, Bottom Control Panel, Settings, My Library
- Global search across wallpapers, tags & colors
- Lock screen support (macOS 26+)
- Shuffle mode with liked/downloaded wallpapers
- New onboarding flow

### v1.3.0 — Screen Saver & Tahoe Support *(October 2025)*

- Full macOS 26 "Tahoe" support with redesigned interface
- Native screen saver support
- New backend architecture for faster data access
- 7-day free trial (replaced free plan)
- 10 language localization

### v1.2.0 — Native Screen Saver *(August 2025)*

- First truly native video screen saver for macOS
- Apple notarized, no admin rights required
- Extremely low resource usage

### v1.1.0 — Stability & Control *(July 2025)*

- Battery-aware mode (auto-pause on battery)
- Sleep & login restoration fixes
- New Display Manager (scale, position, per-display disable)

<details>
<summary><b>View all releases →</b></summary>

See the full [Releases page](https://github.com/alxndlk/wallper-app/releases) for every version since v1.0.7.

</details>

---

## 🌐 Ecosystem

Wallper is built by **[Sandimax](https://sandimax.com)** — an independent team crafting premium digital products with precision and purpose.

<table>
<tr>
<td align="center" width="20%">
<img width="80" height="80" alt="Wallper" src="https://github.com/user-attachments/assets/ba9fd97a-3798-4d1a-bd6e-07f13555efa6" />
<br /><b>Wallper</b>
<br /><sub>Live 4K video wallpapers for macOS</sub>
<br /><a href="https://wallper.app">wallper.app</a>
</td>
<td align="center" width="20%">
<img width="80" height="80" alt="Copier" src="https://raw.githubusercontent.com/alxndlk/sandimax-site/master/public/copier/logo.png" />
<br /><b>Copier</b>
<br /><sub>Smart encrypted clipboard manager for macOS</sub>
<br /><a href="https://trycopier.app">trycopier.app</a>
</td>
<td align="center" width="20%">
<img width="80" height="80" alt="Calendarly" src="https://raw.githubusercontent.com/alxndlk/sandimax-site/master/public/logos/calendarly.png" />
<br /><b>Calendarly</b>
<br /><sub>Calendar wallpaper for your iPhone Lock Screen</sub>
<br /><a href="https://getcalendarly.com">getcalendarly.com</a>
</td>
<td align="center" width="20%">
<img width="80" height="80" alt="Locora" src="https://raw.githubusercontent.com/alxndlk/sandimax-site/master/public/logos/plane.png" />
<br /><b>Locora</b>
<br /><sub>Travel companion for 50,000+ cities</sub>
<br /><a href="https://locora.app">locora.app</a>
</td>
<td align="center" width="20%">
<img width="80" height="80" alt="Sandimax" src="https://raw.githubusercontent.com/alxndlk/sandimax-site/master/public/sanimax-logo.png" />
<br /><b>Sandimax</b>
<br /><sub>Team & portfolio</sub>
<br /><a href="https://sandimax.com">sandimax.com</a>
</td>
</tr>
</table>

### Product Details

| Product | Platform | Description | Price |
|:--------|:---------|:------------|:------|
| **Wallper** | macOS | 2,000+ live 4K video wallpapers, music sync, lock screen, multi-display, shuffle | License-based |
| **Copier** | macOS | Clipboard manager with iCloud encryption and sync across all Apple devices | $5 one-time |
| **Calendarly** | iOS | Automated calendar integrated into your Lock Screen | [App Store](https://apps.apple.com/app/calendarly-calendar-wallpaper/id6758898739) |
| **Locora** | iOS | City guides with cost of living, weather, transport, restaurants, safety, and more | Coming Soon |

---

## ❓ FAQ

<details>
<summary><b>Does Wallper drain my battery?</b></summary>
<br />
No. Wallper includes Smart Power Management that automatically pauses wallpapers when on battery power, when a fullscreen app is active, or when CPU usage is high. You can configure this behavior in Settings.
<br /><br />
</details>

<details>
<summary><b>Does it work on multiple monitors?</b></summary>
<br />
Yes! Wallper fully supports multi-display setups. You can set different wallpapers on each screen, adjust scale and position per display, and pause wallpapers on individual monitors.
<br /><br />
</details>

<details>
<summary><b>Can I use my own videos?</b></summary>
<br />
Yes. You can upload your own videos to the Wallper library. Videos are processed server-side with automatic color detection, preview generation, and then published to the community library. You can also use downloaded wallpapers locally.
<br /><br />
</details>

<details>
<summary><b>Does it work as a Lock Screen / Screen Saver?</b></summary>
<br />
<b>Lock Screen:</b> Fully supported on macOS 26+ (Tahoe). On older macOS versions, lock screen support is not available due to system-level limitations.<br />
<b>Screen Saver:</b> Fully supported on macOS 26+, partially supported on older versions. The screen saver is Apple notarized and works independently of the main app.
<br /><br />
</details>

<details>
<summary><b>Does it work offline?</b></summary>
<br />
Yes! Downloaded wallpapers play instantly on boot without internet. The library will reload automatically once your connection returns. Wallper uses locally cached video files for offline playback — no more black screens when Wi-Fi hasn't connected yet.
<br /><br />
</details>

<details>
<summary><b>How does Music Sync work?</b></summary>
<br />
Wallper monitors Apple Music and Spotify via system notifications. When a track plays, Wallper extracts colors from the album artwork using k-means++ clustering, generates an animated mesh gradient matching those colors, and applies it as your wallpaper and lock screen. When music stops, your original wallpaper is restored.
<br /><br />
</details>

<details>
<summary><b>What macOS versions are supported?</b></summary>
<br />
Wallper supports <b>macOS 13.0 (Ventura)</b> and later. Some features (lock screen, native screen saver) require <b>macOS 26 (Tahoe)</b> or later. Apple Silicon and Intel Macs are both supported.
<br /><br />
</details>

<details>
<summary><b>Can I get a refund?</b></summary>
<br />
Yes. Automatic refunds are available for purchases within 14 days. Contact <a href="mailto:support@wallper.app">support@wallper.app</a> or the payment provider.
<br /><br />
</details>

<details>
<summary><b>Is there a free trial?</b></summary>
<br />
Yes. Wallper offers a <b>7-day free trial</b> with full access to all features. No credit card required to start.
<br /><br />
</details>

---

## 💬 Community

Join the Wallper community to share wallpapers, request features, and get help:

| Channel | Link |
|:--------|:-----|
| **Discord** | [discord.gg/ksxrdnETuc](https://discord.gg/ksxrdnETuc) |
| **Reddit** | [r/Sandimax](https://www.reddit.com/r/Sandimax/) |
| **GitHub Issues** | [Report bugs & request features](https://github.com/alxndlk/wallper-app/issues) |
| **Email** | [support@wallper.app](mailto:support@wallper.app) |
| **Telegram** | [@alxndlk](https://t.me/alxndlk) |

### Community Stats

- ⭐ Growing GitHub community — [star the repo!](https://github.com/alxndlk/wallper-app/stargazers)
- 👥 **50,000+** active users (as of March 2026)
- 🎬 **2,000+** wallpapers in the library
- 🌍 **10** languages supported
- 📦 **25+** releases since launch

---

## 🔒 Security

We take the security of Wallper seriously. If you've found a vulnerability, please report it responsibly.

- **Email:** [support@wallper.app](mailto:support@wallper.app)
- **Details:** See [SECURITY.md](SECURITY.md) for our full security policy, including response timelines and safe harbor terms.

### App Security

- macOS **App Sandbox** — restricted file system and network access
- **Hardened Runtime** — prevents code injection and tampering
- **Code Signed & Notarized** by Apple — verified identity, no malware
- **License validation** with device binding to prevent abuse
- No behavioral advertising, no personal data sold

---

## 📄 License

**Wallper is proprietary software.** All rights reserved.

Copyright © 2025 Sandimax / WALLPER.
See [license.md](license.md) for the full license terms.

For licensing inquiries, contact: [support@wallper.app](mailto:support@wallper.app)

---

<div align="center">

<br />

**Built with ❤️ by [Sandimax](https://sandimax.com)**

*An independent dev team crafting high-quality digital products with precision and purpose.*

<br />

<a href="https://wallper.app">🌐 Website</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/releases/latest">⬇️ Download</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://discord.gg/ksxrdnETuc">💬 Discord</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://www.reddit.com/r/Sandimax/">🗣 Reddit</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/issues">🐛 Report Bug</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="mailto:support@wallper.app">✉️ Contact</a>

<br />
<br />

</div>
