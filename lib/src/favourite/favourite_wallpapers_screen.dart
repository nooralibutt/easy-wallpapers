import 'package:easy_wallpapers/src/utilities/prefs.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/background_widget.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class FavoriteWallpapersScreen extends StatefulWidget {
  static const String routeName = "/FavoriteWallpapersScreen";

  const FavoriteWallpapersScreen({super.key});

  @override
  State<FavoriteWallpapersScreen> createState() =>
      _FavoriteWallpapersScreenState();
}

class _FavoriteWallpapersScreenState extends State<FavoriteWallpapersScreen> {
  final ScrollController _scrollController = ScrollController();
  List<String> favWallpapers = Prefs.instance.getFavWallpapers();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: BlurBackgroundWidget(child: _buildBody()),
    );
  }

  AppBar _buildAppBar() {
    final theme = Theme.of(context);
    return AppBar(
      iconTheme: IconThemeData(color: theme.secondaryHeaderColor),
      title: const Text("Favorites"),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    if (favWallpapers.isEmpty) {
      return const Center(
          child: Text(
        'There are no favourite wallpapers yet',
      ));
    }
    return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const VerticalSpacing(),
            WallpaperListing(
              favWallpapers,
              _scrollController,
              onPopFullScreen: onPopFullScreen,
            ),
            const VerticalSpacing(),
          ],
        ));
  }

  void onPopFullScreen() {
    final updatedWalls = Prefs.instance.getFavWallpapers();
    if (updatedWalls.length == favWallpapers.length) return;

    setState(() => favWallpapers = updatedWalls);
  }
}
