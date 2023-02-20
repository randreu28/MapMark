import 'package:flutter/material.dart';
import 'package:mapmark/home.dart';
import 'package:mapmark/mapathon.dart';
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
        initialRoute: "/",
        routes: {
          "/": (context) => const Home(),
          "/mapathon": (context) => const Mapathon(),
        });
  }
}
