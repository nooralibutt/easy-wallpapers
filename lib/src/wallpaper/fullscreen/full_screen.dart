import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_wallpapers/src/favourite/favourite_icon.dart';
import 'package:easy_wallpapers/src/models/FullScreenArguments.dart';
import 'package:easy_wallpapers/src/models/color_filter_data.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_placeholder.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/components/wallpaper_info.dart';
import 'package:easy_wallpapers/src/widgets/color_filter_preview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menu_buttons.dart';

class FullScreenView extends StatefulWidget {
  static const String routeName = "/fullScreenView";
  final FullScreenArguments arguments;

  const FullScreenView({super.key, required this.arguments});

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _fullScreenGlobalKey = GlobalKey();

  int selectedIndex = -1;
  ColorFilterData selected = ColorFilterData.filters.first;
  bool favSelected = false;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == -1) {
      selectedIndex = widget.arguments.selectedIndex ?? 0;
    }
    final list = widget.arguments.list ?? [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: RepaintBoundary(
              key: _fullScreenGlobalKey,
              child: PageView.builder(
                itemCount: list.length,
                onPageChanged: _onPageChanged,
                controller: PageController(initialPage: selectedIndex),
                itemBuilder: (context, position) {
                  return CachedNetworkImage(
                      imageUrl: list[position],
                      imageBuilder: (context, provider) {
                        return ColorFiltered(
                          colorFilter: ColorFilter.matrix(selected.matrix),
                          child: Image(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      placeholder: (context, url) =>
                          const WallpaperPlaceholder(),
                      fit: BoxFit.cover);
                },
              ),
            ),
          ),
          Positioned.fill(
            bottom: 100,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).padding.top / 2 + 70,
            child: MenuButtons(widget.arguments, _fullScreenGlobalKey),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top / 2 + 110,
            right: 20,
            child: FavouriteIcon(list[selectedIndex]),
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top / 2 + 20,
              right: 20,
              child: _buildCrossIcon()),
          Positioned(
            top: MediaQuery.of(context).padding.top / 2 + 65,
            right: 20,
            child: WallpaperInfo(list[selectedIndex]),
          ),
          Positioned(
            height: 100,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ColorFilterPreviewItem(
                  ColorFilterData.filters[index],
                  onTap: onTapFilter),
              itemCount: ColorFilterData.filters.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCrossIcon() => IconButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        if (_scaffoldKey.currentContext != null) {
          Navigator.pop(_scaffoldKey.currentContext!);
        }
      },
      icon: Icon(CupertinoIcons.clear_circled_solid,
          color: Theme.of(context).secondaryHeaderColor));

  void _onPageChanged(int page) {
    setState(() {
      selectedIndex = page;
      selected = ColorFilterData.filters.first;
    });
  }

  void onTapFilter(ColorFilterData filterData) {
    setState(() => selected = filterData);
  }
}
