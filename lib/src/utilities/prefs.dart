import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();
  static Prefs get instance => _instance;

  factory Prefs() {
    return _instance;
  }
  Prefs._internal();

  static late SharedPreferences _prefs;

  static const KEY_FAV_WALLS = "FAV_WALLS";

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  Future<bool> toggleFavWallpaper(String favWall) {
    final favList = getFavWallpapers();
    if (favList.contains(favWall)) {
      favList.remove(favWall);
    } else {
      favList.add(favWall);
    }
    return _prefs.setStringList(KEY_FAV_WALLS, favList);
  }

  List<String> getFavWallpapers() => _prefs.getStringList(KEY_FAV_WALLS) ?? [];
}
