import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazwalls/pages/full_screen_image/full_screen_image.dart';
import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:fazwalls/wallpaper/services/wallpaper_services.dart';
import 'package:fazwalls/wallpaper_provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WallpaperServices _wallpaperServices = WallpaperServices();
  void toggleFavorite(WallpaperModels wallpaper) {
    context.read<FavoriteWallpapersProvider>().toggleFavorite(wallpaper);
  }

  @override
  Widget build(BuildContext context) {
    List<WallpaperModels> favoriteWallpapers =
        context.watch<FavoriteWallpapersProvider>().favoriteWallpapers;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _wallpaperServices.getallWallpaper(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading wallpapers'),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data?.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: MediaQuery.of(context).size.height / 2,
                  childAspectRatio: 20,
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final wallpaper = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(wallpaper: wallpaper),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height / 2,
                                  imageUrl: wallpaper.url.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    toggleFavorite(wallpaper);
                                  },
                                  icon: Icon(
                                    favoriteWallpapers.contains(wallpaper)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        favoriteWallpapers.contains(wallpaper)
                                            ? Colors.red
                                            : Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No wallpapers available'),
              );
            }
          },
        ),
      ),
    );
  }
}
