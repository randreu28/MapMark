import 'package:flutter/material.dart';
import 'package:mapmark/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Mapathons"),
      ),
      body: StreamBuilder(
        stream: db.from('mapathons').select().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData == false) {
            return const Center(child: Text("Loading..."));
          } else {
            List<Mapathon> mapathons = [];

            for (dynamic rawMapathon in snapshot.data) {
              mapathons.add(Mapathon.fromJson(rawMapathon));
            }

            mapathons = List.from(mapathons.where(
              (mapathon) => mapathon.hasEnded,
            ));

            return ListView.builder(
              itemCount: mapathons.length,
              itemBuilder: (context, index) {
                final mapathon = mapathons[index];
                final dateFormat = DateFormat('dd/MM/yyyy');

                return ListTile(
                  title: Text(mapathon.name),
                  subtitle: Text(
                    "From ${dateFormat.format(mapathon.startDate)} to ${dateFormat.format(mapathon.endDate)}",
                  ),
                  textColor: mapathon.hasStarted ? null : Colors.grey,
                  onTap: () {
                    if (mapathon.hasStarted) {
                      Navigator.pushNamed(
                        context,
                        "/map",
                        arguments: mapathon,
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
