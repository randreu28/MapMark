import 'package:latlong2/latlong.dart';

class Mapathon {
  int id;
  String name;
  DateTime createdAt;
  DateTime startDate;
  DateTime endDate;

  Mapathon({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
  });

  bool get hasStarted {
    return startDate.isBefore(DateTime.now());
  }

  bool get hasEnded {
    return endDate.isAfter(DateTime.now());
  }

  Mapathon.fromJson(dynamic data)
      : id = data["id"],
        name = data["name"],
        createdAt = DateTime.parse(data["created_at"]),
        startDate = DateTime.parse(data["start_date"]),
        endDate = DateTime.parse(data["end_date"]);
}

class Point {
  int id;
  int mapathonID;
  DateTime createdAt;
  LatLng coordinates;
  String picture;

  Point(
      {required this.id,
      required this.mapathonID,
      required this.createdAt,
      required this.coordinates,
      required this.picture});

  Point.fromJson(dynamic data)
      : id = data["id"],
        mapathonID = data["mapathon"],
        createdAt = DateTime.parse(data["created_at"]),
        coordinates = LatLng(data["position_x"], data["position_y"]),
        picture = data["picture"];
}
