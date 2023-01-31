import 'package:easy_wallpapers/src/favourite/favourite_wallpapers_screen.dart';
import 'package:flutter/material.dart';

class HomeHeaderText extends StatelessWidget {
  final String name;
  const HomeHeaderText({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontWeight: FontWeight.w700);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: "4K",
                style: style,
                children: [
                  TextSpan(
                      text: ' HD',
                      style: style.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                  TextSpan(text: ' $name'),
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
            })
      ],
    );
  }
}
