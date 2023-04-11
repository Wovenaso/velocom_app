import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocom_app/screens/widgets/dialogoPer.dart';
import 'package:velocom_app/screens/widgets/listaPuertos.dart';
import 'funciones.dart';

class MovilScreen extends StatefulWidget {
  const MovilScreen({super.key});

  @override
  State<MovilScreen> createState() => _MovilScreenState();
}

class _MovilScreenState extends State<MovilScreen> {
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
      appBar: AppBar(
        title: Image.asset("images/logovelocom.png", width: 100, height: 70),
        actions: <Widget>[
          const Text(
            "Monitoreo",
            style: TextStyle(
                height: 4.0, leadingDistribution: TextLeadingDistribution.even),
          ),
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
          ),
          const SizedBox(width: 70),
          IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
                timer?.cancel();
                cerrar_sesion(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: ValueListenableBuilder(
              valueListenable: valores_nuevos,
              builder: (BuildContext context, value, Widget? child) {
                return ListViewPuertos(
                  puertos: lista_p,
                  valores: valores_nuevos.value,
                );
              },
            ),
          )),
      ]),
    );
  }
}
