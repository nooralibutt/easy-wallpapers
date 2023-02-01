import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/models/enums.dart';
import 'package:easy_wallpapers/src/utilities/network_manager.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/header_text.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/categoryScreen";
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = EasyWallpaperController.of(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        title: HomeHeaderText(
            leadingText: controller.leadingTitle, name: controller.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            if (controller.placementBuilder != null)
              controller.placementBuilder!
                  .call(context, WallpaperPlacement.wallpaperCategoryTop),
            const VerticalSpacing(),
            _fetchTrendingWallpapers(context, widget.category),
            const VerticalSpacing(),
          ],
        ),
      ),
    );
  }

  Widget _fetchTrendingWallpapers(BuildContext context, String category) {
    final wallpapers = NetworkManager.getWallpapersByCategory(
            category, EasyWallpaperController.of(context).wallpaperUrls) ??
        [];
    return WallpaperListing(wallpapers, _scrollController);
  }
}
