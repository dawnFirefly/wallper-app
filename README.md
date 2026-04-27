<div align="center">

# Wallper - MacOS Live Wallpapers App

**Live 4K video wallpapers for macOS — seamless, silent, beautiful.**

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

</div>

---

## Table of Contents

- [Features](#features)
- [Video Wallpapers](#video-wallpapers)
- [Music Sync](#music-sync)
- [Multi-Display](#multi-display)
- [Lock Screen & Screen Saver](#lock-screen--screen-saver)
- [Smart Power Management](#smart-power-management)
- [Playback Controls](#playback-controls)
- [Shuffle Mode](#shuffle-mode)
- [Localization](#localization)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Install](#install)
- [FAQ](#faq)
- [Community](#community)
- [Security](#security)
- [License](#license)

---

## Features

### Video Wallpapers

- Curated 4K wallpapers in the cloud library
- 4K / 60fps H.264 & H.265 playback
- Metal-optimized rendering pipeline
- Low-latency hardware decoding
- Seamless infinite looping
- Circular reveal animation on apply
- Upload your own videos to the community library
- Like, save, and organize wallpapers in My Media

### Multi-Display

- Apply wallpapers to individual or all displays simultaneously
- Per-screen pan, zoom & transform controls
- Automatic restore on screen changes & Space switches
- Menu bar color adaptation via still-frame extraction
- Smart wallpaper persistence across reboots
- Independent wallpaper per monitor
- Per-display pause & video switching

### Smart Library

- Filter by resolution, duration, file size, category & date
- Sort wallpapers by multiple criteria
- Cloud-synced library with metadata & likes
- Intelligent search across wallpapers, tags & colors
- Background downloads with progress tracking
- Efficient in-memory caching for instant scrolling
- Lazy batch loading — no lag on large libraries
- "Recommended For You" & "Recently Created" sections

### Security & Updates

- macOS App Sandbox & Hardened Runtime
- Code Signed & Notarized by Apple
- Automatic update checking — orange dot appears on menubar icon
- In-app Software Update screen with full release notes
- License validation & multi-device management
- Battery-aware pause
- Apple Silicon native (M1/M2/M3/M4)

### Music Sync

- Apple Music & Spotify dual player support
- Album-colored dynamic lockscreen gradients
- Cursor-reactive mesh gradient backgrounds
- Real-time playback controls in menu bar
- Automatic switching between music players
- Lockscreen video caching for instant replays

### Lock Screen & Screen Saver

- Native lock screen wallpapers (macOS 26+)
- Custom screen saver with your chosen video
- HEVC 10-bit transcoding for lock screen compatibility
- Automatic lock screen restore after unlock
- Stable across multiple lock/unlock cycles

---

## Video Wallpapers

Wallper turns your macOS desktop into a living canvas with a curated library of 4K video wallpapers.

**How it works:**

1. **Browse** — Explore the cloud library with smart filters: resolution, duration, file size, category, color, and date
2. **Preview** — Hover to see animated previews, generated server-side and cached locally
3. **Apply** — One click to download and set as wallpaper with a smooth circular reveal animation
4. **Enjoy** — Seamless infinite loop, zero flicker, Metal-optimized rendering

**Video engine:**

- **Metal rendering pipeline** — hardware-accelerated video compositing with minimal GPU overhead
- **AVPlayerLooper** — seamless looping without visible cuts or delays
- **Hardware decoding** — H.264 and H.265 (HEVC) decoded on the video engine, not the CPU
- **Retina rendering toggle** — optional hi-DPI rendering, or reduce GPU load on older Macs
- **Smart quality presets** — Auto, High, Balanced, or Performance modes
- **Maximum resolution & frame rate limits** — fine-grained control over resource usage

**Community uploads:**

- Upload multiple videos at once
- Automatic color and type detection
- Backend-driven preview generation
- Creator name attribution displayed in the app
- Videos reviewed and published to the global library

---

## Music Sync

Wallper reacts to your music in real time, syncing your desktop and lock screen to the currently playing track.

**Supported players:** Apple Music and Spotify — both supported simultaneously with automatic switching.

**How it works:**

1. **Color extraction** — Album artwork analyzed using k-means++ clustering for accurate palette
2. **Spatial arrangement** — Colors spatially arranged to preserve the visual structure of the album cover
3. **Mesh gradient** — GPU-efficient animated mesh gradient with organic blob motion reacts to your cursor
4. **Lock screen video** — Seamlessly looping gradient video rendered in HEVC, applied as lock screen wallpaper (macOS 26+)
5. **Desktop background** — On macOS 14–15, a 4K gradient image rendered from album colors and applied as desktop wallpaper

**Dual player behavior:**

- When one player pauses, wallpaper automatically switches to the other active player
- When both players are paused, original wallpaper and lock screen are restored
- Active player state tracked in real-time via system notifications
- Debounced pause handling to prevent rapid flickers

**Performance:**

- Artwork cached in memory — returning to a previously played album skips the download
- Lock screen video rendered at a reduced resolution for faster encoding
- Three-tier lockscreen caching: fast path → cache path → slow path (full download + transcode)
- Smooth lerp interpolation for cursor-reactive gradients

---

## Multi-Display

Wallper fully supports multi-monitor setups with independent per-display control.

**Display Manager:**

- Set different wallpapers on each monitor
- Adjust scale per screen
- Fine-tune X/Y offset per display
- Disable wallpapers on specific monitors
- Wallpapers auto-center, optimized for ultrawide setups

**Menu bar:**

- Wallper lives in your menu bar — always accessible, never in the way
- Per-display pause & video switching directly from the menu bar
- Like wallpapers, open Shuffle, and clear cache from the menu bar
- CPU and RAM monitoring — live system stats at a glance
- App version displayed in the menu bar view
- Menu bar color adapts to match the current wallpaper

**Smart behavior:**

- Wallpapers automatically restore after sleep, wake, unlock, screen changes, and Space switches
- Each screen's wallpaper tracked and restored individually
- Smart window memory — the app remembers window positions across launches

---

## Lock Screen & Screen Saver

**Lock Screen (macOS 26+)**

Set any Wallper video as your lock screen wallpaper. Appears natively in System Settings → Wallpapers. HEVC 10-bit full transcode ensures consistent playback across all video sources. Automatic restore after unlock, stable across multiple lock/unlock cycles.

**Screen Saver (macOS 26+)**

Native video screen saver for macOS. Apple notarized — no administrator rights required. Works independently of the Wallper app. Videos automatically converted to `.mov` with HEVC encoding.

**macOS compatibility:**

| Feature | macOS 14–15 | macOS 26+ |
|:--------|:------------|:----------|
| Desktop wallpaper | ✅ | ✅ |
| Lock screen | — | ✅ Native |
| Screen saver | — | ✅ |
| Music desktop sync | ✅ gradient image | ✅ gradient video |

---

## Smart Power Management

Wallper is designed to be invisible when you need your Mac's full performance.

**Automatic pausing:**

| Condition | Behavior |
|:----------|:---------|
| On battery | Pause automatically, resume when plugged in |
| Fullscreen app | Pause when any app goes fullscreen |
| High CPU | Pause when CPU usage exceeds 80% |
| Sleep / Wake | Restore properly after wake |
| Manual pause | Won't auto-resume if you paused manually |

**System monitors:**

- **FullscreenMonitor** — detects fullscreen apps via workspace notifications
- **CPUMonitor** — monitors system load, pauses when CPU > 80%
- **PowerMonitor** — tracks battery vs. AC power state
- Smart debouncing to prevent false triggers
- State persists across app restarts

**Quality scaling:**

- Auto quality preset — dynamically adjusts based on system resources
- Battery quality reduction — automatically lowers quality on battery power
- Retina rendering toggle — disable hi-DPI rendering to cut GPU load
- Maximum resolution and frame rate limits configurable in Settings

---

## Playback Controls

All settings apply instantly — no reload, no flicker.

| Setting | Description |
|:--------|:------------|
| Video Quality Preset | Auto, High, Balanced, Performance |
| Maximum Resolution | Limit the maximum video resolution |
| Frame Rate Limit | Cap playback frame rate |
| Video Volume | Slider with real-time preview |
| Video Speed | Playback speed adjustment (per display) |
| Transition Duration | Control cross-fade between wallpapers |
| Start Delay | Delay before wallpaper begins playing |

**Bottom control panel:**

- Pause / switch wallpapers instantly
- Set wallpapers per display
- Toggle lock screen wallpaper
- Like wallpapers directly from the panel
- Track info and playback controls for Music Sync

---

## Shuffle Mode

Automatically rotate through your wallpaper collection.

- **Sources:** Liked wallpapers, Downloaded wallpapers, or both
- **Switch interval:** configurable timer for automatic rotation
- **Seamless switching** — smooth transitions between wallpapers
- **Lock screen inclusion** — shuffle applies to lock screen too (macOS 26+)
- Accessible directly from the menu bar

---

## Localization

Wallper is available in multiple languages: English, Chinese, Russian, French, Italian, Spanish, Ukrainian, Japanese, Korean, German.

---

**Key design decisions:**

- **Server-side library generation** — the video list is built on the backend and sent ready-to-use, removing any library size ceiling
- **Backend-rendered previews** — thumbnails are generated server-side and cached, not computed on the client
- **Three-tier caching** — NSCache (memory) → URLSession disk cache → CDN (network)
- **Offline-first** — downloaded wallpapers load instantly on boot without internet; library reloads when connection returns
- **KVO-based settings** — targeted KVO on specific keys instead of broad UserDefaults observation

---

## Tech Stack

| Layer | Technologies |
|:------|:-------------|
| App | Swift · SwiftUI · AVKit · AVFoundation · Combine · CoreAnimation · Metal · CoreImage · CoreGraphics · VideoToolbox |
| System | SMAppService · NSWorkspace · NSEvent · CGWindowList · IOKit |
| Backend | AWS Lambda (Node.js) · API Gateway · DynamoDB · CloudFront |
| Storage | Amazon S3 · MinIO · NSCache · URLSession · FileManager |
| Encoding | H.264 · H.265 (HEVC 10-bit) · VideoToolbox · .mov / .mp4 |
| Infrastructure | HTTPS · JSON APIs · GZIP compression · CORS · CDN |
| DevOps | GitHub Actions · macOS Code Signing · Notarization · GitHub Releases |
| Payments | Stripe (one-time purchase) |
| Website | [wallper.app](https://wallper.app) — Next.js · TypeScript · Vercel |

---

## Install

**Requirements:**

- macOS 14.0 or later
- Apple Silicon (M1/M2/M3/M4) or Intel Mac
- Internet required for library browsing; offline playback after download

<div align="center">

<br />

**[⬇️ Download Wallper.dmg](https://github.com/alxndlk/wallper-app/releases/latest)**

<br />

</div>

**Steps:**

1. Download `Wallper.dmg` from the [latest release](https://github.com/alxndlk/wallper-app/releases/latest)
2. Open the DMG and drag **Wallper** to your Applications folder
3. Launch Wallper — it lives in your **menu bar**
4. On first launch, the app will ask if you want to start at login
5. Browse the library, pick a wallpaper, and click **Set as Wallpaper**

> Wallper is code-signed and notarized by Apple. If macOS shows a Gatekeeper warning, right-click the app → Open.

**Uninstall:**

1. Quit Wallper from the menu bar
2. Drag Wallper from Applications to Trash
3. Optionally clear cache: `~/Library/Caches/com.sandimax.wallper`

---

## FAQ

<details>
<summary>Does Wallper drain my battery?</summary>
<br />
No. Smart Power Management automatically pauses wallpapers when on battery, when a fullscreen app is active, or when CPU usage is high. Configurable in Settings.
<br /><br />
</details>

<details>
<summary>Does it work on multiple monitors?</summary>
<br />
Yes. Wallper fully supports multi-display setups. You can set different wallpapers on each screen, adjust scale and position per display, and pause wallpapers on individual monitors.
<br /><br />
</details>

<details>
<summary>Can I use my own videos?</summary>
<br />
Yes. Use My Media to import local video files directly into the app. Videos are playable immediately — no upload required. You can also upload your own videos to the community library to share with other Wallper users.
<br /><br />
</details>

<details>
<summary>Does it work as a Lock Screen / Screen Saver?</summary>
<br />
Lock Screen: fully supported on macOS 26+ (Tahoe). Not available on older macOS versions due to system-level limitations.<br />
Screen Saver: requires macOS 26 (Tahoe). The screen saver is Apple notarized and works independently of the main app.
<br /><br />
</details>

<details>
<summary>Does it work offline?</summary>
<br />
Yes. Downloaded wallpapers play instantly on boot without internet. The library reloads automatically once your connection returns.
<br /><br />
</details>

<details>
<summary>How does Music Sync work?</summary>
<br />
Wallper monitors Apple Music and Spotify. When a track plays, Wallper extracts colors from the album artwork using k-means++ clustering, generates an animated mesh gradient, and applies it as your wallpaper and lock screen. When music stops, your original wallpaper is restored.
<br /><br />
</details>

<details>
<summary>What macOS versions are supported?</summary>
<br />
macOS 14.0 and later. Lock screen and native screen saver require macOS 26 (Tahoe). Apple Silicon and Intel Macs are both supported.
<br /><br />
</details>

<details>
<summary>Is there a free trial?</summary>
<br />
Yes. Wallper offers a free trial with full access to all features. No credit card required to start.
<br /><br />
</details>

<details>
<summary>Can I get a refund?</summary>
<br />
Yes. Contact <a href="mailto:support@wallper.app">support@wallper.app</a> for refund requests.
<br /><br />
</details>

---

## Community

| Channel | Link |
|:--------|:-----|
| Discord | [discord.gg/ksxrdnETuc](https://discord.gg/ksxrdnETuc) |
| GitHub Issues | [Report bugs & request features](https://github.com/alxndlk/wallper-app/issues) |
| Email | [support@wallper.app](mailto:support@wallper.app) |

---

## Security

Found a vulnerability? Please report it responsibly.

- **Email:** [support@wallper.app](mailto:support@wallper.app)
- See [SECURITY.md](SECURITY.md) for response timelines and safe harbor terms.

**App security:**

- macOS App Sandbox — restricted file system and network access
- Hardened Runtime — prevents code injection and tampering
- Code Signed & Notarized by Apple
- License validation with device binding
- No behavioral advertising, no personal data sold

---

## License

Wallper is proprietary software. All rights reserved.

Copyright © 2025 Sandimax / WALLPER.
See [license.md](license.md) for the full license terms.

For licensing inquiries: [support@wallper.app](mailto:support@wallper.app)

---

<div align="center">

<br />

**Built with ❤️ by [Sandimax](https://sandimax.com)**

<br />

<a href="https://wallper.app">Website</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/releases/latest">Download</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://discord.gg/ksxrdnETuc">Discord</a>
&nbsp;&nbsp;·&nbsp;&nbsp;
<a href="https://github.com/alxndlk/wallper-app/issues">Report Bug</a>

<br />
<br />

</div>
