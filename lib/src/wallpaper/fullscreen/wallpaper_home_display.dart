import 'dart:io';

import 'package:easy_wallpapers/src/utilities/constants.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/lock_screen_container.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class WallpaperHomeDisplay extends StatelessWidget {
  static const String imagePathBaseIos = baseAssetUrlIos;
  static const String imagePathBaseAndroid = baseAssetUrlAndroid;

  static const List<String> iOSIcons = [
    'App Store',
    'Calender',
    'Camera',
    'Clock',
    'Compass',
    'Game Center',
    'iMusic',
    'iStocks',
    'Mail',
    'Map',
    'Messages',
    'Notes',
    'Phone',
    'Photos',
    'Settings',
    'Weather'
  ];

  static const List<String> androidIcons = [
    'Phone',
    'Messages',
    'Play Store',
    'Chrome'
  ];

  final IconData iconData;
  final VoidCallback onTap;

  const WallpaperHomeDisplay(this.iconData, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Platform.isAndroid ? _buildForAndroid() : _buildForIos(),
    );
  }

  _buildForAndroid() {
    return LockScreenContainer(
      iconData,
      onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VerticalSpacing(of: 100),
          const GoogleSearchWidget(),
          const VerticalSpacing(),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 25,
            spacing: 20,
            children: List.generate(
                androidIcons.length,
                (index) =>
                    DisplayWidget(androidIcons[index], imagePathBaseAndroid)),
          )
        ],
      ),
    );
  }

  _buildForIos() {
    return Column(
      children: [
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 25,
            spacing: 30,
            children: List.generate(iOSIcons.length,
                (index) => DisplayWidget(iOSIcons[index], imagePathBaseIos)),
          ),
        ),
        LockScreenContainer.getAnimatedPaintWidget(iconData, onTap),
      ],
    );
  }
}

class DisplayWidget extends StatelessWidget {
  final String name;
  final String imagePath;

  const DisplayWidget(this.name, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth / 4 - 30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network('$imagePath$name.png'),
              const VerticalSpacing(of: 5),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(name),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GoogleSearchWidget extends StatelessWidget {
  const GoogleSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width * 0.85,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.black87),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Image.network(
            '${baseAssetUrlAndroid}google_search.png',
            height: 22,
          ),
          const Spacer(),
          Text(
            'Say "Hey Google"',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
