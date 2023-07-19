import 'package:flutter/material.dart';
import 'package:velocom_app/screens/funciones.dart';
import 'package:velocom_app/screens/widgets/dialogoPer.dart';

class ListViewPuertos extends StatefulWidget {
  final List<dynamic> puertos;
  final List<dynamic> valores;

  const ListViewPuertos(
      {super.key, this.puertos = const [], this.valores = const []});

  @override
  State<ListViewPuertos> createState() => _ListViewPuertos();
}

class _ListViewPuertos extends State<ListViewPuertos> {
  String msj = '';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.puertos.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          tileColor: Colors.orange[200],
          value: widget.puertos[index][2],
          title: Text(
              "${widget.puertos[index][0]} \nDesc: ${widget.puertos[index][1]}"),
          subtitle: Text(
              "RX: ${widget.valores[index][0]}, TX: ${widget.valores[index][1]}"),
          onChanged: (bool? value) {
            if (tipo == "admin") {
              showDialog(
                context: context,
                builder: (context) {
                  if (widget.puertos[index][2]) {
                    msj =
                        "Deseas apagar el puerto ${widget.puertos[index][0]}?";
                  } else {
                    msj =
                        "Deseas encender el puerto ${widget.puertos[index][0]}?";
                  }
                  return AlertDialog(
                    title: const Text("Apagar/Prender Puerto"),
                    content: Text(msj),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            setState(() {
                              print(index);
                              apagar_encender(index, context);
                              widget.puertos[index][2] = value!;
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text("Si")),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text("No")),
                    ],
                  );
                },
              );
            } else {
              alertaPersonalizada(context, Colors.amber,
                  "No tienes permiso para realizar esta acción");
            }
          },
        );
      },
    );
  }
}
