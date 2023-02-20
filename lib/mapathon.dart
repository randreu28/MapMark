import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapmark/secrets.dart';

class Mapathon extends StatelessWidget {
  const Mapathon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ));
  }
}
