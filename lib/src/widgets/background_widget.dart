import 'dart:ui';

import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/utilities/constants.dart';
import 'package:flutter/material.dart';

class BlurBackgroundWidget extends StatelessWidget {
  final Widget child;

  const BlurBackgroundWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = EasyWallpaperController.of(context);
    final img = controller.bgImage;
    if (img == null) return child;

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkAssetImage(
          imgPath: img,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: child,
          ),
        ),
      ],
    );
  }
}
