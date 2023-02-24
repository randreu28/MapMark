import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapmark/models.dart';
import 'package:mapmark/secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Map extends StatefulWidget {
  const Map({
    super.key,
  });

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    final mapathon = ModalRoute.of(context)?.settings.arguments as Mapathon;
    final db = Supabase.instance.client;

    Future<List<Point>> loadPoints() async {
      List<Point> newPoints = [];

      final rawData = await db
          .from("points")
          .select()
          .filter("mapathon", "eq", mapathon.id);

      for (dynamic rawPoint in rawData) {
        newPoints.add(Point.fromJson(rawPoint));
      }
      return newPoints;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(mapathon.name),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              /* TODO: Add new point */
            },
            child: const Icon(Icons.camera_alt)),
        body: Stack(
          children: [
            FutureBuilder(
              future: loadPoints(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Loading.."),
                  );
                }
                return FlutterMap(
                  options: MapOptions(
                    minZoom: 5,
                    maxZoom: 16,
                    zoom: 13,
                    center: LatLng(41.429795, 2.194170),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/randreu28/clebruq3o001201r15xtwdylg/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}",
                      additionalOptions: const {
                        "access_token": MAPBOX_KEY,
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        for (Point point in snapshot.data!) ...[
                          Marker(
                            point: point.coordinates,
                            builder: (context) {
                              return const Icon(
                                size: 30,
                                /* TODO: Make the icon's end point actually point at the specific loction. Maybe a local transformation based on the icon's size */
                                Icons.location_on,
                                color: Colors.teal,
                              );
                            },
                          ),
                        ],
                        /* TODO: Make this following marker the user's current position */
                        Marker(
                          point: LatLng(41.429795, 2.194170),
                          builder: (context) {
                            return const Icon(
                              Icons.location_history,
                              /* TODO: Make the icon more evidently a representation of the user's current position (pulsing circle?)*/
                              color: Colors.teal,
                            );
                          },
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ],
        ));
  }
}
