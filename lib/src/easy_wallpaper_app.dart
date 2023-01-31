import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/favourite/favourite_wallpapers_screen.dart';
import 'package:easy_wallpapers/src/wallpaper/category/category_screen.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/full_screen.dart';
import 'package:easy_wallpapers/src/wallpaper/wallpaper_home_screen.dart';
import 'package:flutter/material.dart';

class EasyWallpaperApp extends StatelessWidget {
  /// This [leadingTitle] will be added before main [title]
  final String? leadingTitle;

  /// This is the main title text
  final String? title;

  /// This will be added as a background image with blur effect
  final String? bgImage;

  /// This is for safe area space
  final bool topSafeArea;

  /// This will be list of all wallpaper URLs that a user wants to add inn  the package
  final List<String> wallpaperUrls;

  const EasyWallpaperApp({
    Key? key,
    required this.wallpaperUrls,
    this.title,
    this.leadingTitle,
    this.bgImage,
    this.topSafeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyWallpaperController(
      wallpaperUrls: wallpaperUrls,
      leadingTitle: leadingTitle,
      title: title,
      context: context,
      bgImage: bgImage,
      topSafeArea: topSafeArea,

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
              return _generatePage(const CategoryScreen());
            case FullScreenView.routeName:
              return _generatePage(const FullScreenView());
          }
          return null;
        },
      ),
    );
  }

  Route _generatePage(child) => MaterialPageRoute(builder: (_) => child);

  static void launchApp(
    BuildContext context, {
    /// This [leadingTitle] will be added before main [title]
    final String? leadingTitle,

    /// This is the main title text
    final String? title,

    /// This will be added as a background image with blur effect
    final String? bgImage,

    /// This is for safe area space
    final bool topSafeArea = true,

    /// This will be list of all wallpaper URLs that a user wants to add inn  the package
    required final List<String> wallpaperUrls,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => Scaffold(
            body: EasyWallpaperApp(
              leadingTitle: leadingTitle,
              title: title,
              bgImage: bgImage,
              topSafeArea: topSafeArea,
              wallpaperUrls: wallpaperUrls,
            ),
          ),
        ),
      );
}
