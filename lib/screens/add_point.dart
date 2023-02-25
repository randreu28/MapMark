import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../models.dart';

class AddPoint extends StatelessWidget {
  const AddPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    final mapathon = args["mapathon"] as Mapathon;
    final currentPosition = args["currentPosition"] as LatLng;

    return const Placeholder();
  }
}
