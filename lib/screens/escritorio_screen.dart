import 'dart:async';
import 'package:flutter/material.dart';
import 'package:velocom_app/screens/widgets/dialogoPer.dart';
import 'package:velocom_app/screens/widgets/listaPuertos.dart';
import 'funciones.dart';

class EscritorioScreen extends StatefulWidget {
  const EscritorioScreen({super.key});

  @override
  State<EscritorioScreen> createState() => _EscritorioScreenState();
}

class _EscritorioScreenState extends State<EscritorioScreen> {
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
          timer?.cancel();
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
            aspectRatio: 16/9,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 600,
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