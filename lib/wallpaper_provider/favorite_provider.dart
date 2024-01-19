import 'dart:convert';
import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteWallpapersProvider extends ChangeNotifier {
  List<WallpaperModels> _favoriteWallpapers = [];
  late SharedPreferences _prefs;

  FavoriteWallpapersProvider() {
    _loadFavorites();
  }

  List<WallpaperModels> get favoriteWallpapers => _favoriteWallpapers;

  void toggleFavorite(WallpaperModels wallpaper) {
    if (_favoriteWallpapers.contains(wallpaper)) {
      _favoriteWallpapers.remove(wallpaper);
    } else {
      _favoriteWallpapers.add(wallpaper);
    }
    _saveFavorites();
    notifyListeners();
  }

  void removeFavorite(WallpaperModels wallpaper) {
    _favoriteWallpapers.remove(wallpaper);
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    final jsonString = _prefs.getString('favoriteWallpapers');
    if (jsonString != null) {
      final List<dynamic> jsonData = jsonDecode(jsonString);
      _favoriteWallpapers = jsonData.map((e) => WallpaperModels.fromJson(e)).toList();
    }
  }

  Future<void> _saveFavorites() async {
    final jsonData = _favoriteWallpapers.map((wallpaper) => wallpaper.toJson()).toList();
    final jsonString = jsonEncode(jsonData);
    await _prefs.setString('favoriteWallpapers', jsonString);
  }
}
