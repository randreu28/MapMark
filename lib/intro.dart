import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IntroScreens(),
    );
  }
}

class IntroScreens extends StatefulWidget {
  const IntroScreens({super.key});

  @override
  State<IntroScreens> createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  List<ContentConfig> listContentConfig = [
    const ContentConfig(
      title: "Welcome to MapMark!",
      description:
          "MapMark is an app to participate in mapathons, a coordinated maping event",
      pathImage: "media/navigator.png",
    ),
    const ContentConfig(
      title: "Capture points",
      description: "You can use your camera to capture interesting points",
      pathImage: "media/camera.png",
    ),
    const ContentConfig(
      title: "Contribute to the mapathon",
      description: "Submit your points and fill the map with data!",
      pathImage: "media/map.png",
    ),
  ];

  void onDone() {
    Navigator.pushNamed(context, "/");
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.teal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      doneButtonStyle: myButtonStyle(),
      nextButtonStyle: myButtonStyle(),
      prevButtonStyle: myButtonStyle(),
      skipButtonStyle: myButtonStyle(),
      listContentConfig: listContentConfig,
      indicatorConfig: const IndicatorConfig(
        colorIndicator: Colors.teal,
        colorActiveIndicator: Colors.tealAccent,
      ),
      onDonePress: onDone,
      onSkipPress: onDone,
    );
  }
}
