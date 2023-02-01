import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:circular_menu/circular_menu.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_wallpapers/src/models/FullScreenArguments.dart';
import 'package:easy_wallpapers/src/utilities/constants.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/lock_screen_container.dart';
import 'package:easy_wallpapers/src/wallpaper/fullscreen/wallpaper_home_display.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class MenuButtons extends StatefulWidget {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  final FullScreenArguments arguments;
  final GlobalKey fullScreenGlobalKey;

  const MenuButtons(this.arguments, this.fullScreenGlobalKey, {super.key});

  @override
  State<MenuButtons> createState() => _MenuButtonsState();

  static String _getRandomString() => String.fromCharCodes(Iterable.generate(
      8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
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
    if (context.mounted) {
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
    }

    return false;
  }

  void _saveToGallery() async {
    HapticFeedback.mediumImpact();

    if (!await _isPermissionGranted()) return;
    if (context.mounted) {
      final boundary = widget.fullScreenGlobalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final list = byteData!.buffer.asUint8List();
      _saveImage(list);
    }
  }

  void _saveImage(Uint8List list) async {
    final Map<dynamic, dynamic> result =
        await ImageGallerySaver.saveImage(list);
    final bool isSuccess = result['isSuccess'] ?? false;
    if (isSuccess) {
      await showCustomAlertDialog(
          _key.currentContext!, 'Downloaded', 'Wallpaper saved to gallery');
    } else {
      final String errorMessage = result['errorMessage'];
      showCustomAlertDialog(_key.currentContext!, 'Failed',
          'Failed to save image to gallery. Please try later: $errorMessage');
    }
  }

  void _setWallpaper() async {
    int? location = await _showSetWallpaperDialog();
    if (location == null) return;

    final ProgressDialog pd = ProgressDialog(context: _key.currentContext);
    pd.show(
        max: 100, msg: 'Downloading ...', progressType: ProgressType.valuable);

    try {
      final dir = await getTemporaryDirectory();
      final imagePath = "${dir.path}/{${MenuButtons._getRandomString}()}.jpg";
      await Dio().download(
        widget.arguments.item,
        imagePath,
        onReceiveProgress: (rec, total) {
          int progress = (((rec / total) * 100).toInt());
          pd.update(value: progress);

          if (rec == total) {
            pd.close();
          }
        },
      );

      await WallpaperManagerFlutter()
          .setwallpaperfromFile(Directory(imagePath), location);

      String locationStr;
      if (location == WallpaperManagerFlutter.HOME_SCREEN) {
        locationStr = 'Home Screen';
      } else if (location == WallpaperManagerFlutter.LOCK_SCREEN) {
        locationStr = 'Lock Screen';
      } else {
        locationStr = 'Both Screens';
      }

      await showCustomAlertDialog(
          _key.currentContext!, 'Info', 'Wallpaper is set to $locationStr');
    } catch (e) {
      showCustomAlertDialog(_key.currentContext!, 'Failed',
          'Failed to set wallpaper. Please try later: ${e.toString()}');
    }
  }

  Future<int?> _showSetWallpaperDialog() {
    return showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Set wallpaper'),
        children: [
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, WallpaperManagerFlutter.HOME_SCREEN),
            child: Row(
              children: const [
                Icon(Icons.home),
                HorizontalSpacing(),
                Text('Home Screen'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, WallpaperManagerFlutter.LOCK_SCREEN),
            child: Row(
              children: const [
                Icon(Icons.lock),
                HorizontalSpacing(),
                Text('Lock Screen'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, WallpaperManagerFlutter.BOTH_SCREENS),
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
