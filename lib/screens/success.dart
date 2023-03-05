import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Your point has been uploaded succesfully!"),
          TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/map'));
              },
              child: const Text("Go back"))
        ],
      )),
    );
  }
}
