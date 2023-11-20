import 'dart:async' show Future;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_placeholder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const baseAssetUrlAndroid =
    'http://github.com/nooralibutt/easy-wallpapers/raw/master/assets/images/wallpapers/android/';
const baseAssetUrlIos =
    'http://github.com/nooralibutt/easy-wallpapers/raw/master/assets/images/wallpapers/ios/';

Future showCustomAlertDialog(BuildContext context, String title, String message,
    [String? buttonTitle]) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(buttonTitle ?? "OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

void printLog(String str) {
  if (kDebugMode) {
    print(str);
  }
}

class CachedNetworkAssetImage extends StatelessWidget {
  final String imgPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  const CachedNetworkAssetImage(
      {Key? key,
      required this.imgPath,
      required this.fit,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imgPath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imgPath,
        placeholder: (_, __) => const WallpaperPlaceholder(),
        errorWidget: (_, __, ___) => const WallpaperPlaceholder(),
        fit: fit,
        width: width,
        height: height,
      );
    }

    return Image(
      image: AssetImage(imgPath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;

        return const WallpaperPlaceholder();
      },
    );
  }
}
