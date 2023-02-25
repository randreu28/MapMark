import 'package:flutter/material.dart';
import 'package:mapmark/screens/home.dart';
import 'package:mapmark/screens/intro.dart';
import 'package:mapmark/screens/map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'secrets.dart';

Future<void> main() async {
  await Supabase.initialize(url: URL, anonKey: ANON_KEY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        });
  }
}
