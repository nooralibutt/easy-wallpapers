import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WallpaperInfo extends StatefulWidget {
  final String wallpaperUrl;

  const WallpaperInfo(
    this.wallpaperUrl, {
    Key? key,
  }) : super(key: key);

  @override
  State<WallpaperInfo> createState() => _WallpaperInfoState();
}

class _WallpaperInfoState extends State<WallpaperInfo> {
  Future<ui.Image> _getImageInfo() {
    Completer<ui.Image> completer = Completer<ui.Image>();
    Image.network(widget.wallpaperUrl)
        .image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => infoDialog(context),
      icon: Icon(Icons.info,
          size: 30, color: Theme.of(context).secondaryHeaderColor),
    );
  }

  void infoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(8),
          children: [
            FutureBuilder<ui.Image>(
              future: _getImageInfo(),
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                if (snapshot.hasData) {
                  ui.Image? image = snapshot.data;
                  return Text(
                    '${image?.width}x${image?.height}',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  );
                } else {
                  return const Text('Loading...');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
