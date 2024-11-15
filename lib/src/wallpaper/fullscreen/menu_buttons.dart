import 'dart:io';
import 'dart:ui' as ui;

import 'package:circular_menu/circular_menu.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_wallpapers/easy_wallpapers.dart';
import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/models/full_screen_arguments.dart';
import 'package:easy_wallpapers/src/utilities/constants.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/lock_screen_container.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/wallpaper_home_display.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class MenuButtons extends StatefulWidget {
  final FullScreenArguments arguments;
  final GlobalKey fullScreenGlobalKey;

  const MenuButtons(this.arguments, this.fullScreenGlobalKey, {super.key});

  @override
  State<MenuButtons> createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  final _key = GlobalKey<CircularMenuState>();

  bool _showLockScreen = false;
  bool _showHomeScreen = false;

  @override
  Widget build(BuildContext context) {
    const animDuration = Duration(milliseconds: 300);
    return Stack(
      fit: StackFit.expand,
      children: [
        IgnorePointer(
          ignoring: _showHomeScreen,
          child: _buildLockScreenContainer(animDuration),
        ),
        IgnorePointer(
          ignoring: _showLockScreen,
          child: _buildHomeScreenContainer(animDuration),
        ),
        IgnorePointer(
          ignoring: _showLockScreen || _showHomeScreen,
          child: AnimatedOpacity(
            duration: animDuration,
            opacity: _showLockScreen || _showHomeScreen ? 0 : 1,
            child: CircularMenu(
              alignment: Alignment.bottomCenter,
              toggleButtonSize: 25,
              toggleButtonColor: Colors.black,
              key: _key,
              items: [
                CircularMenuItem(
                    icon: Icons.home,
                    color: Colors.black,
                    onTap: _onTapHomeScreen),
                CircularMenuItem(
                    icon: Icons.download_rounded,
                    color: Colors.black,
                    onTap: _saveToGallery),
                if (Platform.isAndroid)
                  CircularMenuItem(
                      icon: Icons.format_paint,
                      color: Colors.black,
                      onTap: _setWallpaper),
                CircularMenuItem(
                    icon: Icons.lock,
                    color: Colors.black,
                    onTap: _onTapLockScreen),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLockScreenContainer(Duration animDuration) {
    final icon =
        Platform.isAndroid ? Icons.format_paint : Icons.download_rounded;
    final onTap = Platform.isAndroid ? _setWallpaper : _saveToGallery;
    return AnimatedOpacity(
      duration: animDuration,
      opacity: _showLockScreen ? 1 : 0,
      child: LockScreenContainer(icon, onTap),
    );
  }

  Widget _buildHomeScreenContainer(Duration animDuration) {
    final icon =
        Platform.isAndroid ? Icons.format_paint : Icons.download_rounded;
    final onTap = Platform.isAndroid ? _setWallpaper : _saveToGallery;
    return AnimatedOpacity(
      duration: animDuration,
      opacity: _showHomeScreen ? 1 : 0,
      child: WallpaperHomeDisplay(icon, onTap),
    );
  }

  _onTapLockScreen() => setState(() => _showLockScreen = true);
  _onTapHomeScreen() => setState(() => _showHomeScreen = true);

  Future<bool> _isPermissionGranted() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        if (await Permission.photos.request().isGranted) {
          return true;
        }
      } else if (await Permission.storage.request().isGranted) {
        return true;
      }
    }

    if (Platform.isIOS && await Permission.photosAddOnly.request().isGranted) {
      return true;
    }

    final context = this.context;
    if (!context.mounted) return false;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permission'),
        content: const Text(
            'In order to save wallpaper, we need gallery permission'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Dismiss')),
          TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Open Settings'))
        ],
      ),
    );

    return false;
  }

  Future<void> _saveToGallery() async {
    HapticFeedback.mediumImpact();

    if (!await _isPermissionGranted()) return;

    BuildContext context = this.context;
    if (!context.mounted) return;

    final controller = EasyWallpaperController.of(context);
    bool canSetOrDownload = true;
    if (controller.onSetOrDownloadWallpaper != null) {
      canSetOrDownload =
          await controller.onSetOrDownloadWallpaper!.call(context);
    }

    if (context.mounted && canSetOrDownload) {
      final boundary = widget.fullScreenGlobalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final list = byteData!.buffer.asUint8List();
      await _saveImage(list);
    }
  }

  Future<void> _saveImage(Uint8List list) async {
    // Save Image with try-catch
    try {
      await Gal.putImageBytes(list);

      showCustomAlertDialog(
          _key.currentContext!, 'Downloaded', 'Wallpaper saved to gallery');
    } on GalException catch (e) {
      showCustomAlertDialog(_key.currentContext!, 'Failed',
          'Failed to save image to gallery. Please try later: ${e.type.message}');
    }
  }

  void _setWallpaper() async {
    final context = this.context;

    final controller = EasyWallpaperController.of(context);
    int? location = await _showSetWallpaperDialog(controller);
    if (location == null) return;

    final String locationStr;
    if (location == WallpaperManagerPlus.homeScreen) {
      locationStr = 'Home Screen';
    } else if (location == WallpaperManagerPlus.lockScreen) {
      locationStr = 'Lock Screen';
    } else {
      locationStr = 'Both Screens';
    }

    final arguments = widget.arguments;
    final file = await DefaultCacheManager()
        .getSingleFile(arguments.list![arguments.selectedIndex!]);
    try {
      await WallpaperManagerPlus().setWallpaper(file, location);
    } on Exception catch (e) {
      await showCustomAlertDialog(_key.currentContext!, 'Error',
          'Unable to set wallpaper to $locationStr\nError: ${e.toString()}');
    }

    await showCustomAlertDialog(
        _key.currentContext!, 'Info', 'Wallpaper is set to $locationStr');

    if (!context.mounted) return;

    controller.onTapEvent?.call(context, WallpaperEventAction.setWallpaper);
  }

  Future<int?> _showSetWallpaperDialog(EasyWallpaperController controller) {
    return showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Set wallpaper'),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              bool canSetOrDownload = true;
              if (controller.onSetOrDownloadWallpaper != null) {
                await controller.onSetOrDownloadWallpaper?.call(context);
              }
              if (context.mounted && canSetOrDownload) {
                Navigator.pop(context, WallpaperManagerPlus.homeScreen);
              }
            },
            child: Row(
              children: const [
                Icon(Icons.home),
                HorizontalSpacing(),
                Text('Home Screen'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              bool canSetOrDownload = true;
              if (controller.onSetOrDownloadWallpaper != null) {
                await controller.onSetOrDownloadWallpaper?.call(context);
              }
              if (context.mounted && canSetOrDownload) {
                Navigator.pop(context, WallpaperManagerPlus.lockScreen);
              }
            },
            child: Row(
              children: const [
                Icon(Icons.lock),
                HorizontalSpacing(),
                Text('Lock Screen'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              bool canSetOrDownload = true;
              if (controller.onSetOrDownloadWallpaper != null) {
                await controller.onSetOrDownloadWallpaper?.call(context);
              }
              if (context.mounted && canSetOrDownload) {
                Navigator.pop(context, WallpaperManagerPlus.bothScreens);
              }
            },
            child: Row(
              children: const [
                Icon(Icons.phone_iphone),
                HorizontalSpacing(),
                Text('Both Screens'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
