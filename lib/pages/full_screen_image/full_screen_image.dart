import 'package:fazwalls/wallpaper/models/wallpaper_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreenImage extends StatefulWidget {
  final WallpaperModels wallpaper;

  const FullScreenImage({super.key, required this.wallpaper});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _isSettingWallpaper = false;
  int _selectedLocation = WallpaperManager.HOME_SCREEN;

  void _setWallpaper() async {
    setState(() {
      _isSettingWallpaper = true;
    });

    var file = await DefaultCacheManager().getSingleFile(widget.wallpaper.url.toString());
    await WallpaperManager.setWallpaperFromFile(
      file.path,
      _selectedLocation,
    );

    setState(() {
      _isSettingWallpaper = false;
    });
  }

  void _showSetWallpaperOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark(),
          child: CupertinoActionSheet(
            title: const Text('Set Wallpaper'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    _selectedLocation = WallpaperManager.HOME_SCREEN;
                  });
                  Navigator.pop(context);
                  _setWallpaper();
                },
                child: const Text('Set as Home Screen'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    _selectedLocation = WallpaperManager.LOCK_SCREEN;
                  });
                  Navigator.pop(context);
                  _setWallpaper();
                },
                child: const Text('Set as Lock Screen'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    _selectedLocation = WallpaperManager.BOTH_SCREEN;
                  });
                  Navigator.pop(context);
                  _setWallpaper();
                },
                child: const Text('Set as Both'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: const Text('Cancel'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.network(
              widget.wallpaper.url.toString(),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: _isSettingWallpaper
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 40,
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _showSetWallpaperOptions(context);
                        },
                        child: Text(
                          'Set Wallpaper',
                          style: Theme.of(context).textTheme.headlineSmall
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
