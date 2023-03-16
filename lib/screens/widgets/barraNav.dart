import 'package:flutter/material.dart';

class barraNavegacion extends StatefulWidget {
  const barraNavegacion({super.key});

  @override
  State<barraNavegacion> createState() => _barraNavegacionState();
}

class _barraNavegacionState extends State<barraNavegacion> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int value) {
        setState(() {
          index = value;
          print(index);
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.emoji_people), label: ""),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: "Cerrar Sesion",
        )
      ],
    );
    ;
  }
}
