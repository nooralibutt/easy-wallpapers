import 'package:easy_wallpapers/src/models/wallpaper_category.dart';

class NetworkManager {
  static final List<WallpaperCategory> _categories = [];

  static List<WallpaperCategory>? getCategories(
      final Map<String, dynamic> wallpaperUrls) {
    if (_categories.isNotEmpty) return _categories;

    try {
      wallpaperUrls.forEach((key, value) {
        _categories.add(WallpaperCategory(
            key.toString(), (value as List<dynamic>).first as String));
      });

      return _categories;
    } catch (error) {}
    return null;
  }

  static List<String>? getWallpapersByCategory(
      String category, Map<String, dynamic> wallpaperUrls) {
    if (wallpaperUrls.containsKey(category) &&
        wallpaperUrls[category] is List<String>) {
      return wallpaperUrls[category];
    }

    try {
      final docSnapshot = wallpaperUrls[category];
      if (docSnapshot == null) return [];

      List<String> wallpapers = [];
      wallpapers = List.from(docSnapshot);
      wallpaperUrls[category] = wallpapers;
      return wallpapers;
    } catch (error) {}
    return null;
  }
}
