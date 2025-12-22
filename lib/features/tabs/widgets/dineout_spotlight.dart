import 'package:flutter/material.dart';

class DineoutSpotlight extends StatelessWidget {
  const DineoutSpotlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: const Text(
        "Dineout Spotlight Section",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
