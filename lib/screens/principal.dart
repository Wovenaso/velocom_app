import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:velocom_app/screens/escritorio_screen.dart';
import 'package:velocom_app/screens/movil_screen.dart';
import 'package:velocom_app/screens/widgets/responsive_layout.dart';

class PrincipalWidget extends StatelessWidget {
  const PrincipalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        movilBody: const MovilScreen(), 
        escritorioBody: const EscritorioScreen(),
      ),
    );
  }
}