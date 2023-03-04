import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  CameraException? cameraException;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    final mapathon = args["mapathon"] as Mapathon;
    final currentPosition = args["currentPosition"] as LatLng;

    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (_controller.value.isInitialized == false) {
            return const Center(
              child: Text(
                  "We couldn't access to your camera. Please enable it in your device's configuration",
                  textAlign: TextAlign.center),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UploadPicture(
                  imagePath: image.path,
                  mapathon: mapathon,
                  currentPosition: currentPosition,
                ),
              ),
            );
          } on CameraException catch (error) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("There has been an error"),
                  content: Text(
                    error.description != null
                        ? error.description!
                        : "Error unknown",
                  ),
                  actions: [
                    /* TODO: Add an action to invoke phone settings https://stackoverflow.com/questions/44709434/how-do-i-invoke-the-phone-settings-from-flutter-dart-application */
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class UploadPicture extends StatefulWidget {
  final String imagePath;
  final Mapathon mapathon;
  final LatLng currentPosition;

  const UploadPicture({
    super.key,
    required this.imagePath,
    required this.mapathon,
    required this.currentPosition,
  });

  @override
  State<UploadPicture> createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  @override
  Widget build(BuildContext context) {
    final db = Supabase.instance.client;

    uploadPic() async {
      try {
        final now = DateTime.now().toString();
        final picture = File(widget.imagePath);

        //Upload image to bucket
        await db.storage.from('pictures').upload(
              now,
              picture,
            );

        //Retrieve the public url of the image in the bucket
        final String publicUrl = db.storage.from('pictures').getPublicUrl(now);

        //Add point
        await db.from("points").insert({
          "latitude": widget.currentPosition.latitude,
          "longitude": widget.currentPosition.longitude,
          "mapathon": widget.mapathon.id,
          "picture": publicUrl
        });
      } catch (err) {
        print(err);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      floatingActionButton:
          FloatingActionButton(onPressed: uploadPic, child: Icon(Icons.upload)),
      body: Image.file(File(widget.imagePath)),
    );
  }
}
