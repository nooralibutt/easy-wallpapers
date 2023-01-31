import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_wallpapers/src/wallpaper/category/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String? imgUrls, title;

  const CategoryTile({super.key, required this.imgUrls, required this.title});

  @override
  Widget build(BuildContext context) {
    const width = 120.0;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: title);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imgUrls == null
                  ? Container(
                      height: width / 2, width: width, color: Colors.black)
                  : CachedNetworkImage(
                      imageUrl: imgUrls!,
                      height: width / 2,
                      width: width,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              height: width / 2,
              width: width,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: width / 2,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  title ?? 'N/A',
                  style: theme.textTheme.headlineSmall!
                      .copyWith(color: theme.secondaryHeaderColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
