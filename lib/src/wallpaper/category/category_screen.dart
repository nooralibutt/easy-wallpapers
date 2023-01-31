import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/utilities/network_manager.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/header_text.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/categoryScreen";

  const CategoryScreen({super.key});

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
    String category = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: _buildAppBar(category),
      body: _buildBody(context, category),
    );
  }

  AppBar _buildAppBar(String category) {
    return AppBar(
      title: HomeHeaderText(name: category),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context, String category) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const VerticalSpacing(),
                _fetchTrendingWallpapers(context, category),
                const VerticalSpacing(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _fetchTrendingWallpapers(BuildContext context, String category) {
    final wallpapers = NetworkManager.getWallpapersByCategory(
            category, EasyWallpaperController.of(context).wallpaperUrls) ??
        [];
    return WallpaperListing(wallpapers, _scrollController);
  }
}
