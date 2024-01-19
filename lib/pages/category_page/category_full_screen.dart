import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazwalls/pages/full_screen_image/full_screen_image.dart';
import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:flutter/material.dart';

class CategoryDetailPage extends StatelessWidget {
  final String category;
  final List<WallpaperModels> wallpapers;

  const CategoryDetailPage({
    super.key,
    required this.category,
    required this.wallpapers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: MediaQuery.of(context).size.height / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 13,
          mainAxisSpacing: 15,
        ),
        itemCount: wallpapers.length,
        itemBuilder: (context, index) {
          final wallpaper = wallpapers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(wallpaper: wallpaper),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  imageUrl: wallpaper.url.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
