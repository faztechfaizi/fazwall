class WallpaperModels {
  String? name;
  String? author;
  String? url;
  String? thumbnail;
  String? collections;
  bool? downloadable;
  String? dimensions;
  String? copyright;

  WallpaperModels({
    this.name,
    this.author,
    this.url,
    this.thumbnail,
    this.collections,
    this.downloadable,
    this.dimensions,
    this.copyright,
  });

  WallpaperModels.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    collections = json['collections'];
    downloadable = json['downloadable'];
    dimensions = json['dimensions'];
    copyright = json['copyright'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['author'] = this.author;
    data['url'] = this.url;
    data['thumbnail'] = this.thumbnail;
    data['collections'] = this.collections;
    data['downloadable'] = this.downloadable;
    data['dimensions'] = this.dimensions;
    data['copyright'] = this.copyright;
    return data;
  }

  static List<String> getUniqueCategories(List<WallpaperModels> wallpapers) {
    Set<String> uniqueCategories = {};
    for (var wallpaper in wallpapers) {
      if (wallpaper.collections != null && wallpaper.collections!.isNotEmpty) {
        uniqueCategories.add(wallpaper.collections!);
      }
    }
    return uniqueCategories.toList();
  }
}
