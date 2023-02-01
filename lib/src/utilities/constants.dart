import 'dart:async' show Future;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_placeholder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future showCustomAlertDialog(BuildContext context, String title, String message,
    [String? buttonTitle]) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(buttonTitle ?? "OK"),
    onPressed: () => Navigator.of(context).pop(),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [okButton],
  );
  // show the dialog
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future showRewardedAdAlertDialog(BuildContext context,
    {required VoidCallback onWatchAd,
    required String title,
    required String content}) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () => Navigator.of(context).pop(),
  );
  Widget watchAdButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
      onWatchAd.call();
    },
    child: const Text("Watch Ad"),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [okButton, watchAdButton],
  );
  // show the dialog
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => alert,
  );
}

void printLog(String str) {
  if (kDebugMode) {
    print(str);
  }
}

class ImageWidget extends StatelessWidget {
  final String imgPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  const ImageWidget(
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
