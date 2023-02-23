import 'package:easy_wallpapers/src/models/enums.dart';
import 'package:easy_wallpapers/src/models/wallpaper_category.dart';
import 'package:flutter/material.dart';

typedef PlacementBuilder = Widget Function(BuildContext, WallpaperPlacement);
typedef EventActionCallback = void Function(BuildContext, WallpaperEventAction);

class EasyWallpaperController extends InheritedWidget {
  const EasyWallpaperController({
    super.key,
    this.leadingTitle,
    required this.title,
    this.bgImage,
    required this.wallpaperUrls,
    required super.child,
    this.placementBuilder,
    this.isTrendingEnabled = true,
    this.onTapEvent,
    this.onSetOrDownloadWallpaper,
    required this.categories,
    required this.context,
  });

  /// This [leadingTitle] will be added before main [title]
  final String? leadingTitle;

  /// This is the main title text
  final String title;

  /// This will be added as a background image with blur effect
  final String? bgImage;

  /// This will be list of all wallpaper URLs that a user wants to add inn  the package
  final Map<String, dynamic> wallpaperUrls;

  /// [placementBuilder] is used to build your custom widget at specific places
  final PlacementBuilder? placementBuilder;

  /// [onTapEvent] will be call on every event preformed by the user
  final EventActionCallback? onTapEvent;

  /// [onSetOrDownloadWallpaper] will be call when user set or download wallpaper
  final Future<bool> Function(BuildContext)? onSetOrDownloadWallpaper;

  final List<WallpaperCategory> categories;

  /// If this [isTrendingEnabled = true], package gather all wallpapers
  /// automatically and create a new category called trending
  final bool isTrendingEnabled;

  final BuildContext context;

  static EasyWallpaperController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<EasyWallpaperController>();
  }

  static EasyWallpaperController of(BuildContext context) {
    final EasyWallpaperController? result = maybeOf(context);
    assert(result != null, 'No Presentation found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(EasyWallpaperController oldWidget) =>
      wallpaperUrls != oldWidget.wallpaperUrls;
}
