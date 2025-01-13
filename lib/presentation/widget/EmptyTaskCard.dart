import 'package:flutter/material.dart';

class EmptyTaskCard extends StatelessWidget {
  const EmptyTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SizedBox(
        height: 100,
        child: Center(
          child: ClipOval(
            child: Image.asset('assets/images/empty.png'),
          ),
        ),
      ),
      Container(height: 20),
      const Text(
        "il n'y pas de tâche",
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Text(
          "Appuyez sur la zone de saisie ci-dessus pour ajouter une nouvelle tache.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    ],);
  }
}
