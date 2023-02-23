import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/models/enums.dart';
import 'package:easy_wallpapers/src/utilities/network_manager.dart';
import 'package:easy_wallpapers/src/wallpaper/components/category_builder.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/background_widget.dart';
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
    final controller = EasyWallpaperController.of(context);
    final mainContext = controller.context;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        leading: (ModalRoute.of(mainContext)?.canPop ?? false)
            ? CloseButton(onPressed: Navigator.of(mainContext).pop)
            : null,
        title: HomeHeaderText(
            leadingText: controller.leadingTitle, name: controller.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlurBackgroundWidget(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VerticalSpacing(of: 60),
              SizedBox(height: MediaQuery.of(context).padding.top),
              Column(
                children: [
                  if (controller.placementBuilder != null)
                    controller.placementBuilder!
                        .call(context, WallpaperPlacement.wallpaperHomeTop),
                  const VerticalSpacing(),
                  CategoryBuilder(controller.categories),
                  _fetchTrendingWallpapers(controller),
                ],
              ),
              const VerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fetchTrendingWallpapers(EasyWallpaperController controller) {
    List<String> wallpapers = [];
    if (controller.categories.isNotEmpty) {
      wallpapers = NetworkManager.getWallpapersByCategory(
              controller.categories.first.title, controller.wallpaperUrls) ??
          [];
    }
    if (controller.isTrendingEnabled) {
      final List<String> trendingWallpapers = [];
      for (var element in controller.categories) {
        final category =
            controller.wallpaperUrls[element.title] as List<String>;
        trendingWallpapers.addAll(category);
      }
      wallpapers = trendingWallpapers;
    }

    if (wallpapers.isEmpty) {
      return Text(
        'There is something wrong!\nPlease check your internet connection',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.white),
      );
    }
    return WallpaperListing(wallpapers, _scrollController);
  }
}
