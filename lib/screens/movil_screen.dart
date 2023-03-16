import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocom_app/screens/widgets/barraNav.dart';
import 'package:velocom_app/screens/widgets/dialogoPer.dart';
import 'package:velocom_app/screens/widgets/listaPuertos.dart';
import 'funciones.dart';

class MovilScreen extends StatefulWidget {
  const MovilScreen({super.key});

  @override
  State<MovilScreen> createState() => _MovilScreenState();
}

class _MovilScreenState extends State<MovilScreen> {
  bool estMonitoreo = false;
  Timer? timer;

  @override
  void initTimer(context) {
    if (timer != null && timer!.isActive) return;

    timer = Timer.periodic(
      const Duration(seconds: 15),
      (timer) {
        setState(() {
          try {
            monitoreo(context);
          } on Exception catch (e) {
            alertaPersonalizada(context, Colors.red, e.toString());
          }
          print("Datos actualizados!");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          cerrar_sesion(context);
        },
      ),
      appBar: AppBar(
        title: const Text("Velocom Movil"),
        actions: <Widget>[
          Switch.adaptive(
            value: estMonitoreo,
            onChanged: (bool? value) {
              setState(() {
                estMonitoreo = value!;

                if (estMonitoreo) {
                  initTimer(context);
                } else {
                  timer?.cancel();
                }
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.deepOrange[50],
      body: Column(children: [
        AspectRatio(
            aspectRatio: 7 / 8,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 700,
                  color: Colors.orange[200],
                  child: ValueListenableBuilder(
                    valueListenable: valores_nuevos,
                    builder: (BuildContext context, value, Widget? child) {
                      return ListViewPuertos(
                        puertos: lista_p,
                        valores: valores_nuevos.value,
                      );
                    },
                  ),
                )))
      ]),
    );
  }
}
