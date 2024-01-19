import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazwalls/pages/category_page/category_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:fazwalls/wallpaper/services/wallpaper_services.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
  
}

class _CategoryPageState extends State<CategoryPage> {
  final WallpaperServices _wallpaperServices = WallpaperServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: _wallpaperServices.getallWallpaper(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final List<WallpaperModels>? wallpapers = snapshot.data;
            final List<String> uniqueCategories =
                WallpaperModels.getUniqueCategories(wallpapers!);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Collections',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: uniqueCategories.length,
                    itemBuilder: (context, index) {
                      final category = uniqueCategories[index];
                      final categoryWallpapers = wallpapers
                          .where((wallpaper) => wallpaper.collections == category)
                          .toList();

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailPage(
                        category: category,
                        wallpapers: categoryWallpapers,
                      ),
                    ),
                  );
                        },
                        child: GridTile(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: size.width * 0.9,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                            fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: categoryWallpapers.isNotEmpty &&
                                            categoryWallpapers[0].thumbnail != null
                                        ? categoryWallpapers[0].thumbnail!
                                        : '',
                                    width: size.width * 0.9,
                                    height: size.height * 0.3,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 10,
                                  child: Text(
                                    category,
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:Colors.white )
                                    
                                     
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
