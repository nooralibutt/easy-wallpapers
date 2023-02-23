import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/favourite/favourite_wallpapers_screen.dart';
import 'package:easy_wallpapers/src/models/full_screen_arguments.dart';
import 'package:easy_wallpapers/src/utilities/network_manager.dart';
import 'package:easy_wallpapers/src/utilities/prefs.dart';
import 'package:easy_wallpapers/src/wallpaper/category/category_screen.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/full_screen.dart';
import 'package:easy_wallpapers/src/wallpaper/wallpaper_home_screen.dart';
import 'package:flutter/material.dart';

class EasyWallpaperApp extends StatelessWidget {
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

  /// If this [isTrendingEnabled = true], package gather all wallpapers
  /// automatically and create a new category called trending
  final bool isTrendingEnabled;

  const EasyWallpaperApp({
    Key? key,
    required this.wallpaperUrls,
    required this.title,
    this.leadingTitle,
    this.bgImage,
    this.onTapEvent,
    this.onSetOrDownloadWallpaper,
    this.placementBuilder,
    this.isTrendingEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (wallpaperUrls.isNotEmpty) {
            Prefs.instance.setWallpapersData(wallpaperUrls);
          }
          final getSavedWalls = Prefs.instance.getWallpapersData() ?? {};
          final wallpaperCategories =
              NetworkManager.getCategories(getSavedWalls);

          final child = EasyWallpaperController(
            wallpaperUrls: getSavedWalls,
            leadingTitle: leadingTitle,
            title: title,
            placementBuilder: placementBuilder,
            onTapEvent: onTapEvent,
            onSetOrDownloadWallpaper: onSetOrDownloadWallpaper,
            context: context,
            bgImage: bgImage,
            categories: wallpaperCategories ?? [],
            isTrendingEnabled: isTrendingEnabled,

            /// Package has its own navigation
            child: Navigator(
              initialRoute: WallpaperHomeScreen.routeName,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case WallpaperHomeScreen.routeName:
                    return _generatePage(const WallpaperHomeScreen());
                  case FavoriteWallpapersScreen.routeName:
                    return _generatePage(const FavoriteWallpapersScreen());
                  case CategoryScreen.routeName:
                    return _generatePage(
                        CategoryScreen(category: settings.arguments as String));
                  case FullScreenView.routeName:
                    return _generatePage(FullScreenView(
                        arguments: settings.arguments as FullScreenArguments));
                }
                return null;
              },
            ),
          );
          return child;
        }

        return const Center(child: CircularProgressIndicator.adaptive());
      },
      future: Prefs.instance.init(),
    );
  }

  Route _generatePage(child) => MaterialPageRoute(builder: (_) => child);

  static void launchApp(
    BuildContext context, {
    /// This [leadingTitle] will be added before main [title]
    final String? leadingTitle,

    /// This is the main title text
    required final String title,

    /// This will be added as a background image with blur effect
    final String? bgImage,

    /// This will be list of all wallpaper URLs that a user wants to add inn  the package
    required final Map<String, dynamic> wallpaperUrls,

    /// [placementBuilder] is used to build your custom widget at specific places
    final PlacementBuilder? placementBuilder,

    /// [onTapEvent] will be call on every event preformed by the user
    final EventActionCallback? onTapEvent,

    /// [onSetOrDownloadWallpaper] will be call when user set or download wallpaper
    final Future<bool> Function(BuildContext)? onSetOrDownloadWallpaper,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => Scaffold(
            body: EasyWallpaperApp(
              leadingTitle: leadingTitle,
              title: title,
              bgImage: bgImage,
              wallpaperUrls: wallpaperUrls,
              placementBuilder: placementBuilder,
              onTapEvent: onTapEvent,
              onSetOrDownloadWallpaper: onSetOrDownloadWallpaper,
            ),
          ),
        ),
      );
}
