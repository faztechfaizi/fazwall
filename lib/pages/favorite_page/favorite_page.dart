import 'package:fazwalls/pages/full_screen_image/full_screen_image.dart';
import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:fazwalls/wallpaper_provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    void removeFavorite(WallpaperModels wallpaper) {
      context.read<FavoriteWallpapersProvider>().removeFavorite(wallpaper);
    }

    List<WallpaperModels> favoriteWallpapers =
        context.watch<FavoriteWallpapersProvider>().favoriteWallpapers;

    return Scaffold(
      body: GridView.builder(
        itemCount: favoriteWallpapers.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 400,
          crossAxisCount: 2,
          crossAxisSpacing: 13,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          final wallpaper = favoriteWallpapers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(wallpaper: wallpaper),
                ),
              );
            },
            child: Hero(
              tag: wallpaper.url.toString(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        wallpaper.url!,
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          removeFavorite(wallpaper);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
