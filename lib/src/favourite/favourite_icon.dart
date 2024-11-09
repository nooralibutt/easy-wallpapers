import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/models/enums.dart';
import 'package:easy_wallpapers/src/utilities/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavouriteIcon extends StatefulWidget {
  final String wallpaperUrl;
  const FavouriteIcon(this.wallpaperUrl, {super.key});

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();

    updateIsFavourite();
  }

  @override
  void didUpdateWidget(covariant FavouriteIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    updateIsFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onFavPressed,
        icon: isFavourite
            ? const Icon(Icons.favorite, size: 30, color: Colors.red)
            : Icon(Icons.favorite_border,
                size: 30, color: Theme.of(context).secondaryHeaderColor));
  }

  void onFavPressed() {
    HapticFeedback.selectionClick();
    setState(() => isFavourite = !isFavourite);
    Prefs.instance.toggleFavWallpaper(widget.wallpaperUrl);

    EasyWallpaperController.of(context)
        .onTapEvent
        ?.call(context, WallpaperEventAction.addToFavorite);
  }

  void updateIsFavourite() {
    isFavourite =
        Prefs.instance.getFavWallpapers().contains(widget.wallpaperUrl);
  }
}
