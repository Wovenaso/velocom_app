import 'package:flutter/material.dart';

void alertaPersonalizada(context, Color color, String texto) => showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Velocom",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              overflow: TextOverflow.ellipsis
            ),
          ),
          content: Text(
            texto,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              overflow: TextOverflow.ellipsis
            ),
          ),
          backgroundColor: color,
        );
      },
    );
