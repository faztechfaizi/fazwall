
import 'package:flutter/material.dart';



class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key, required this.color, required this.image, required this.text, required this.subtitle, this.button,
   
  });

  //final Size size;
  final Color color;
  final AssetImage image;
  final String  text;
  final String subtitle;
  final ElevatedButton  ? button;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(30),
      color: color,
      child: ListView(
        children: [
          Image(image: image, height: size.height * 0.5),
          Container(
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          if (button != null) button!, // Show the button if it's provided
        ],
      ),
    );
  }
}