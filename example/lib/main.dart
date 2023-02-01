import 'dart:async';

import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:easy_wallpapers/easy_wallpapers.dart';
import 'package:example/model/mock_data.dart';
import 'package:example/model/test_ad_id_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyAds.instance.initialize(
    const TestAdIdManager(),
    fbiOSAdvertiserTrackingEnabled: true,
    fbTestMode: true,
    unityTestMode: true,
    isAgeRestrictedUserForApplovin: false,
    admobConfiguration: RequestConfiguration(
        testDeviceIds: [], maxAdContentRating: MaxAdContentRating.pg),
    adMobAdRequest:
        const AdRequest(nonPersonalizedAds: false, keywords: <String>[]),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, secondaryHeaderColor: Colors.orange),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    EasyAds.instance.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EasyWallpaperApp(
          wallpaperUrls: data,
          title: 'Wallpapers',
          leadingTitle: 'Nice',
          bgImage:
              'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
          placementBuilder: _addPlacements,
          onTapEvent: _onTapEvent,
          onSetOrDownloadWallpaper: _downloadWallpaper,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EasyWallpaperApp.launchApp(
            context,
            wallpaperUrls: data,
            title: 'Wallpapers',
            bgImage:
                'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
            placementBuilder: _addPlacements,
            onTapEvent: _onTapEvent,
            onSetOrDownloadWallpaper: _downloadWallpaper,
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _addPlacements(BuildContext context, WallpaperPlacement placement) {
    switch (placement) {
      case WallpaperPlacement.wallpaperHomeTop:
        return Container(height: 50, width: double.infinity, color: Colors.red);
      case WallpaperPlacement.wallpaperCategoryTop:
        return Container(
            height: 50, width: double.infinity, color: Colors.orange);
      default:
        return const SizedBox();
    }
  }

  void _onTapEvent(BuildContext context, WallpaperEventAction eventAction) {
    printLog(eventAction.name);
  }

  StreamSubscription? _streamSubscription;

  Future<bool> _downloadWallpaper(BuildContext context) {
    bool isAdShowed = false;

    if (EasyAds.instance.showAd(AdUnitType.rewarded)) {
      _streamSubscription?.cancel();
      _streamSubscription = EasyAds.instance.onEvent.listen((event) {
        if (event.adUnitType == AdUnitType.rewarded &&
            event.type == AdEventType.adDismissed) {
          _streamSubscription?.cancel();
        }
      });

      isAdShowed = true;
    }
    return Future.value(isAdShowed);
  }

  void printLog(String str) {
    if (kDebugMode) {
      print(str);
    }
  }
}
