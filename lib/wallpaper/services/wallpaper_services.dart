import 'dart:convert';

import 'package:fazwalls/utils/custom_snackbar.dart';
import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WallpaperServices {
  final client = http.Client();

  Future<List<WallpaperModels>?> getallWallpaper(BuildContext context) async {
    try {
      final response = await client.get(Uri.parse('https://fazcode.b-cdn.net/anime.json'));

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        final List<WallpaperModels> wallpaper =
            responseBody.map((e) => WallpaperModels.fromJson(e)).toList();
            return wallpaper;
      }
    } catch (e) {
      showSnackbar(context, e.toString());
      
    }
    return null;
   
  }
}
