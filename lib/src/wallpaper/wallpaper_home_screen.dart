import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/utilities/network_manager.dart';
import 'package:easy_wallpapers/src/wallpaper/components/category_builder.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/header_text.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class WallpaperHomeScreen extends StatefulWidget {
  static const String routeName = "/WallpaperHomeScreen";

  const WallpaperHomeScreen({super.key});

  @override
  State<WallpaperHomeScreen> createState() => _WallpaperHomeScreenState();
}

class _WallpaperHomeScreenState extends State<WallpaperHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const HomeHeaderText(name: 'Wallpapers'),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const VerticalSpacing(of: 10),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VerticalSpacing(),
                _fetchCategoryData(context),
                const VerticalSpacing(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _fetchCategoryData(BuildContext context) {
    final categories = EasyWallpaperController.of(context).categories;
    return Column(
      children: [
        CategoryBuilder(categories),
        _fetchTrendingWallpapers(context, 'Trending'),
      ],
    );
  }

  Widget _fetchTrendingWallpapers(BuildContext context, String category) {
    final wallpapers = NetworkManager.getWallpapersByCategory(
            category, EasyWallpaperController.of(context).wallpaperUrls) ??
        [];
    if (wallpapers.isEmpty) {
      return const Text(
        'There is something wrong!\nPlease check your internet connection',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      );
    }
    return WallpaperListing(wallpapers, _scrollController);
  }
}
