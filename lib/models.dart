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
    return startDate.isAfter(DateTime.now());
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
