# Easy Wallpapers

[![pub package](https://img.shields.io/pub/v/easy-wallpapers.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/easy-wallpapers)
[![Last Commits](https://img.shields.io/github/last-commit/nooralibutt/easy-wallpapers?logo=git&logoColor=white)](https://github.com/nooralibutt/easy-wallpapers/commits/master)
[![Pull Requests](https://img.shields.io/github/issues-pr/nooralibutt/easy-wallpapers?logo=github&logoColor=white)](https://github.com/nooralibutt/easy-wallpapers/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/nooralibutt/easy-wallpapers?logo=github&logoColor=white)](https://github.com/nooralibutt/easy-wallpapers)
[![License](https://img.shields.io/github/license/nooralibutt/easy-wallpapers?logo=open-source-initiative&logoColor=green)](https://github.com/nooralibutt/easy-wallpapers/blob/master/LICENSE)

**Show some 💙, 👍 the package & ⭐️ the repo to support the project**

## Features
- Input Json formatted wallpaper URLs
- Support for Add to favorite wallpapers
- Support for download wallpapers
- Support to add filters on the wallpapers

![](https://github.com/nooralibutt/easy-wallpapers/blob/master/demo_gif.gif?raw=true)

## How to use
There are two ways to use Easy Wallpaper.

### 1: Stand-Alone App mode

```dart
EasyWallpaperApp.launchApp(
context,
wallpaperUrls: data,
leadingTitle: '4k',
title: 'Wallpapers',
bgImage:
'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
placementBuilder: _addPlacements,
onTapEvent: _onTapEvent,
onSetOrDownloadWallpaper: _downloadWallpaper,
),
```

### 2: Add to Widget-Tree

```dart
EasyWallpaperApp(
context,
wallpaperUrls: data,
leadingTitle: '4k',
title: 'Wallpapers',
bgImage:
'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
placementBuilder: _addPlacements,
onTapEvent: _onTapEvent,
onSetOrDownloadWallpaper: _downloadWallpaper,
),
```

## Additional Info

### Data Model
Prepare model list and pass it to the `EasyWallpaperApp()` widget.

```dart
final data = {
  "Trending": [
    "https://i.pinimg.com/564x/7b/35/0d/7b350dbf3f89414c2e78ca8f4049ef79.jpg",
    "https://i.pinimg.com/564x/2c/15/32/2c15321ad7b51a781280b3771dce7f9f.jpg",
    "https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg",
    "https://i.pinimg.com/564x/f0/0a/d1/f00ad1fbb97d54461ff266107cbf08f4.jpg",
    "https://i.pinimg.com/564x/b0/6f/ef/b06fef53cc9b8919a968a0647b74b6ef.jpg",
    "https://i.pinimg.com/564x/04/1f/84/041f844d07fdcce8498d44a31a57aed7.jpg",
    "https://wallpapercave.com/wp/wp7697442.jpg",
  ],
  "Girls": [
    "https://i.pinimg.com/564x/66/13/cf/6613cfde049567427b2940c86dec5727.jpg",
    "https://i.pinimg.com/564x/fb/cb/7f/fbcb7f40079f97761e74e0b8013bb757.jpg",
    "https://i.pinimg.com/564x/45/f3/fe/45f3fe07118a4798ff9079b630e6f72e.jpg",
    "https://i.pinimg.com/564x/da/55/90/da55902ca3c29caaf6267a5cd6be8da6.jpg",
  ],
  "Boys": [
    "https://i.pinimg.com/564x/a4/9f/59/a49f5962e50fd69c9fd61e3da6e21a66.jpg",
    "https://i.pinimg.com/564x/a9/4f/10/a94f105d2df9ba2dd217f2f4f390b340.jpg",
    "https://i.pinimg.com/564x/54/6c/14/546c14575789924ec3e302296f82d75f.jpg",
    "https://i.pinimg.com/564x/6f/82/8f/6f828fef7a6ab80eba9887ea8a4840f2.jpg",
  ],
  "Realistic": [
    "https://i.pinimg.com/564x/31/19/c3/3119c32ef4d9c4c01ae6ae4e8842dad3.jpg",
    "https://i.pinimg.com/564x/56/02/8a/56028a10e3243009d52bc0a4f9df7e65.jpg",
    "https://i.pinimg.com/564x/65/54/4e/65544ea641ffdb47949064e39daa46c9.jpg",
    "https://i.pinimg.com/564x/df/67/56/df67564e8ab85ccbed7131e879e32665.jpg",
    "https://i.pinimg.com/564x/eb/4c/92/eb4c9273c2eaaed935cc4ef317c38754.jpg",
  ]
};

```

See [Example](https://pub.dev/packages/easy-wallpapers/example) for better understanding.

## Authors
##### Noor Ali Butt
[![GitHub Follow](https://img.shields.io/badge/Connect--blue.svg?logo=Github&longCache=true&style=social&label=Follow)](https://github.com/nooralibutt) [![LinkedIn Link](https://img.shields.io/badge/Connect--blue.svg?logo=linkedin&longCache=true&style=social&label=Connect
)](https://www.linkedin.com/in/nooralibutt)
##### Hanzla Waheed
[![GitHub Follow](https://img.shields.io/badge/Connect--blue.svg?logo=Github&longCache=true&style=social&label=Follow)](https://github.com/mhanzla80) [![LinkedIn Link](https://img.shields.io/badge/Connect--blue.svg?logo=linkedin&longCache=true&style=social&label=Connect
)](https://www.linkedin.com/in/mhanzla80)