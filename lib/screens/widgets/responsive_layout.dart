import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:velocom_app/screens/widgets/dimenciones.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget movilBody;
  final Widget escritorioBody;

  ResponsiveLayout({required this.movilBody, required this.escritorioBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < anchoMovil) {
          return movilBody;
        } else {
          return escritorioBody;
        }
      },
    );
  }
}
