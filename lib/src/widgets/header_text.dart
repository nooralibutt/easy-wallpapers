import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/favourite/favourite_wallpapers_screen.dart';
import 'package:flutter/material.dart';

class HomeHeaderText extends StatelessWidget {
  final String? leadingText;
  final String name;
  const HomeHeaderText({super.key, required this.name, this.leadingText});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontWeight: FontWeight.w700);
    final mainContext = EasyWallpaperController.of(context).context;

    return Row(
      children: [
        if (ModalRoute.of(mainContext)?.canPop ?? false)
          CloseButton(onPressed: Navigator.of(mainContext).pop),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: leadingText ?? '',
                style: style,
                children: [
                  TextSpan(
                    text: ' $name',
                    style: style.copyWith(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          iconSize: 30.0,
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            Navigator.pushNamed(context, FavoriteWallpapersScreen.routeName);
          },
        )
      ],
    );
  }
}
