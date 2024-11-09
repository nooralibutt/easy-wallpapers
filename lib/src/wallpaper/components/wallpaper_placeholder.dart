import 'package:flutter/material.dart';

class WallpaperPlaceholder extends StatelessWidget {
  const WallpaperPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor.withOpacity(0.5),
      child: Icon(Icons.wallpaper,
          size: 50, color: Theme.of(context).colorScheme.primary),
    );
  }
}
