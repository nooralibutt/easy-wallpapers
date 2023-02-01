import 'package:easy_wallpapers/easy_wallpapers.dart';
import 'package:example/model/mock_data.dart';
import 'package:flutter/material.dart';

void main() {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EasyWallpaperApp(
          wallpaperUrls: data,
          title: 'Wallpapers',
          leadingTitle: 'Nice',
          bgImage:
              'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
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
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
