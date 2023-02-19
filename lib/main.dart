import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latlong2/latlong.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
          floatingActionButton: const FloatingActionButton(
              onPressed: null, child: Icon(Icons.camera_alt)),
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  minZoom: 5,
                  maxZoom: 16,
                  zoom: 13,
                  center: LatLng(41.429795, 2.194170),
                ),
                nonRotatedChildren: const [
                  //TODO
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/randreu28/clebruq3o001201r15xtwdylg/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}",
                    additionalOptions: const {
                      "access_token": MAPBOX_KEY,
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }
}
