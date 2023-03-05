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
  String title;
  String description;

  Point({
    required this.id,
    required this.mapathonID,
    required this.createdAt,
    required this.coordinates,
    required this.picture,
    required this.title,
    required this.description,
  });

  Point.fromJson(dynamic data)
      : id = data["id"],
        mapathonID = data["mapathon"],
        createdAt = DateTime.parse(data["created_at"]),
        coordinates = LatLng(data["latitude"], data["longitude"]),
        picture = data["picture"],
        title = data["title"],
        description = data["description"];
}
