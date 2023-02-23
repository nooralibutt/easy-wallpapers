import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();
  static Prefs get instance => _instance;

  factory Prefs() {
    return _instance;
  }
  Prefs._internal();

  static late SharedPreferences _prefs;

  static const _keyFavWalls = "FAV_WALLS";
  static const _keyAllWalls = "ALL_WALLS";

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  Future<bool> toggleFavWallpaper(String favWall) {
    final favList = getFavWallpapers();
    if (favList.contains(favWall)) {
      favList.remove(favWall);
    } else {
      favList.add(favWall);
    }
    return _prefs.setStringList(_keyFavWalls, favList);
  }

  List<String> getFavWallpapers() => _prefs.getStringList(_keyFavWalls) ?? [];

  void setWallpapersData(Map<String, dynamic> wallpapersData) =>
      _prefs.setString(_keyAllWalls, json.encode(wallpapersData));

  Map<String, dynamic>? getWallpapersData() {
    final prefWalls = _prefs.getString(_keyAllWalls);
    if (prefWalls == null) return null;
    return jsonDecode(prefWalls);
  }
}
