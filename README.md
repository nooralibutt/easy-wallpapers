# Easy Wallpapers

[![pub package](https://img.shields.io/pub/v/easy_wallpapers.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/easy_wallpapers)
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
## Permissions
### For iOS:
- For iOS, we have to add the gallery permissons in the `ios/podfile`

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|

      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.photos
        'PERMISSION_PHOTOS=1',

      ]
    end
  end
end
```

in the `ios/Runner/Info.plist`

```
<key>NSPhotoLibraryAddUsageDescription</key>
<string>To save wallpapers to gallery, we need this permission</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>To save wallpapers to gallery, we need this permission</string>
```

### For Android:
Add Following permission in the `manifest.xml` file in android project

```
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
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
