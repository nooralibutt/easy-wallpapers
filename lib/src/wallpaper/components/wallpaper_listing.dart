import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_wallpapers/easy_wallpapers.dart';
import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/models/full_screen_arguments.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/full_screen.dart';
import 'package:flutter/material.dart';

import '../components/wallpaper_placeholder.dart';

class WallpaperListing extends StatefulWidget {
  final List<String> list;
  final ScrollController scrollController;
  final VoidCallback? onPopFullScreen;

  const WallpaperListing(this.list, this.scrollController,
      {super.key, this.onPopFullScreen});

  @override
  State<WallpaperListing> createState() => _WallpaperListingState();
}

class _WallpaperListingState extends State<WallpaperListing> {
  int imagesCount = 20;

  @override
  void initState() {
    widget.scrollController.addListener(_onScrollChanged);
    super.initState();
  }

  void _onScrollChanged() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      imagesCount = imagesCount + 20;
      if (imagesCount >= widget.list.length) {
        imagesCount = widget.list.length;
        widget.scrollController.removeListener(_onScrollChanged);
      }
      EasyWallpaperController.of(context)
          .onTapEvent
          ?.call(context, WallpaperEventAction.wallpaperHomeScrolling);
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrollChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.list.sublist(0, min(widget.list.length, imagesCount));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          children: list.map((str) {
            return WallpaperGridTile(str, () => _onTapItem(str, widget.list));
          }).toList()),
    );
  }

  void _onTapItem(String str, List<String> list) {
    EasyWallpaperController.of(context)
        .onTapEvent
        ?.call(context, WallpaperEventAction.openWallpaper);
    final arguments =
        FullScreenArguments(list: list, selectedIndex: list.indexOf(str));

    if (arguments.list != null) {
      /*   Navigator.pushNamed(context, FullScreenView.routeName,
              arguments: arguments)
          .then((_) => widget.onPopFullScreen?.call());*/
      Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenView(arguments: arguments)))
          .then((_) => widget.onPopFullScreen?.call());
    }
  }
}

class WallpaperGridTile extends StatelessWidget {
  final VoidCallback onTap;
  final String imgURL;

  const WallpaperGridTile(this.imgURL, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
              filterQuality: FilterQuality.high,
              imageUrl: imgURL,
              placeholder: (context, url) => const WallpaperPlaceholder(),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
