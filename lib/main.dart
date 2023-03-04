import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mapmark/screens/add_point.dart';
import 'package:mapmark/screens/home.dart';
import 'package:mapmark/screens/intro.dart';
import 'package:mapmark/screens/map.dart';
import 'package:mapmark/screens/success.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'secrets.dart';

Future<void> main() async {
  await Supabase.initialize(url: URL, anonKey: ANON_KEY);

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MapMark',
        theme: ThemeData.dark(),
        initialRoute: "/intro",
        routes: {
          "/": (context) => const Home(),
          "/intro": (context) => const Intro(),
          "/map": (context) => const Map(),
          "/add-point": (context) => TakePicture(camera: camera),
          "/success": (context) => const Success(),
        });
  }
}
