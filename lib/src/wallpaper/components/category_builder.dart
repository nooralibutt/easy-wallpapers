import 'package:easy_wallpapers/src/models/wallpaper_category.dart';
import 'package:easy_wallpapers/src/wallpaper/components/category_tile.dart';
import 'package:flutter/material.dart';

class CategoryBuilder extends StatelessWidget {
  final List<WallpaperCategory>? list;
  const CategoryBuilder(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: list?.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            /// Create List Item tile
            return CategoryTile(
              imgUrls: list?[index].url,
              title: list?[index].title,
            );
          }),
    );
  }
}
