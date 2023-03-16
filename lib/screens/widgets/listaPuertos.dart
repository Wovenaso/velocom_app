import 'package:flutter/material.dart';
import 'package:velocom_app/screens/funciones.dart';

class ListViewPuertos extends StatefulWidget {
  final List<dynamic> puertos;
  final List<dynamic> valores;

  const ListViewPuertos(
      {super.key, this.puertos = const [], this.valores = const []});

  @override
  State<ListViewPuertos> createState() => _ListViewPuertos();
}

class _ListViewPuertos extends State<ListViewPuertos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.puertos.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          value: widget.puertos[index][2],
          title: Text(
              "${widget.puertos[index][0]} \nDesc: ${widget.puertos[index][1]}"),
          subtitle: Text(
              "RX: ${widget.valores[index][0]}, TX: ${widget.valores[index][1]}"),
          onChanged: (bool? value) {
            setState(() {
              print(index);
              apagar_encender(index, context);
              widget.puertos[index][2] = value!;
            });
          },
        );
      },
    );
  }
}
