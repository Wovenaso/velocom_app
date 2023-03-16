import 'package:flutter/material.dart';
import 'package:velocom_app/screens/widgets/barraNav.dart';

class EscritorioScreen extends StatelessWidget {
  const EscritorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Velocom Escritorio"),
      ),
      backgroundColor: Colors.red[50],
      body: Column(children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 700,
              color: Colors.red[200],
            ),
          ),
        )
      ]),
    );
  }
}
