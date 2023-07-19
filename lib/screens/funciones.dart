import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocom_app/screens/escritorio_screen.dart';
import 'package:velocom_app/screens/log_in.dart';
import 'dart:convert';

import 'package:velocom_app/screens/movil_screen.dart';
import 'package:velocom_app/screens/widgets/dialogoPer.dart';
import 'package:velocom_app/screens/widgets/responsive_layout.dart';

TextEditingController userCon = TextEditingController();
TextEditingController passCon = TextEditingController();
String dispCon = "";

Timer? timer;
bool estMonitoreo = false;

String tipo = '';
List<dynamic> lista_p = [];
List<dynamic> valores = [];
List<dynamic> dispositivos = [];
String usuario_activo = "";

final valores_nuevos = ValueNotifier<List<dynamic>>([0, 0]);
final disp_disponibles = ValueNotifier<List<dynamic>>([0, 0]);

Future<void> obtener_dispositivos(context) async {
  var url = Uri.parse("http://10.254.254.128:5000/dispositivos");

  try {
    http.Response respuesta = await http.get(url);

    switch (respuesta.statusCode) {
      case 200:
        var temp = jsonDecode(respuesta.body);
        print(temp);
        dispositivos = temp['dispositivos'];
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        break;
      case 400:
        alertaPersonalizada(
            context, Colors.amber, "Ocurrio un error inesperado, 400");
        break;
      case 500:
        alertaPersonalizada(
            context, Colors.amber, "Ocurrio un error inesperado, 500");
        break;
    }
  } catch (e) {
    print(e);
    alertaPersonalizada(context, Colors.amber, "Ocurrio un error inesperado");
  }
}

Future<void> inicio_sesion(
    String user, String pass, String disp, context) async {
  print(user);
  print(pass);
  print(disp);

  var url = Uri.parse("http://10.254.254.128:5000/inicio");
  var respuesta;

  if (user.isEmpty) {
    Navigator.of(context).pop();
    alertaPersonalizada(context, Colors.amber, "Escriba un usuario");
    return;
  }
  if (disp.isEmpty) {
    Navigator.of(context).pop();
    alertaPersonalizada(
        context, Colors.amber, "Escriba un dispositivo al que conectarse");
    return;
  }

  try {
    var obj = jsonEncode({'disp': disp, 'usuario': user, 'contra': pass});

    respuesta = await http.post(url,
        headers: {"Content-Type": 'application/json'}, body: obj);

    print(respuesta?.statusCode);
    switch (respuesta?.statusCode) {
      case 200:
        Map r = jsonDecode(respuesta?.body);

        usuario_activo = user;

        lista_p.clear();
        valores_nuevos.value.clear();

        tipo = r['tipo'];
        lista_p = r['puertos'];

        print(lista_p);

        valores = List<dynamic>.generate(lista_p.length, (i) {
          return [0, 0];
        });

        valores_nuevos.value = List<dynamic>.generate(lista_p.length, (index) {
          return [0, 0];
        });

        var screen = ResponsiveLayout(
            movilBody: const MovilScreen(),
            escritorioBody: const EscritorioScreen());

        userCon.clear();
        passCon.clear();
        dispCon = "";
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ));
        break;

      case 403:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon = "";
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;

      case 405:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon = "";
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;

      case 406:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon = "";
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;

      case 410:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon = "";
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;
      case 500:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon = "";
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;
    }
  } on Exception catch (e) {
    userCon.clear();
    passCon.clear();
    dispCon = "";
    print(e);
    Navigator.of(context).pop();
    alertaPersonalizada(context, Colors.amber, "ERROR: ${e.toString()}");
  }
}

Future<void> cerrar_sesion(context) async {
  var url = Uri.parse("http://10.254.254.128:5000/cerrar");
  var respuesta;
  String mensaje = '';
  Color color = Colors.transparent;

  if (usuario_activo.isEmpty) {
    alertaPersonalizada(context, Colors.amber, "No hay usuario conectado");
    lista_p.clear();
    valores.clear();
    valores_nuevos.value.clear();
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
    userCon.clear();
    passCon.clear();
    dispCon = "";
  }

  try {
    var obj = jsonEncode({'usuario': usuario_activo});

    respuesta = await http.post(url,
        headers: {"Content-Type": 'application/json'}, body: obj);

    switch (respuesta?.statusCode) {
      case 200:
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        userCon.clear();
        passCon.clear();
        dispCon = "";
        color = Colors.green;
        mensaje = "Se cerro la sesion adecuadamente";
        break;
      case 400:
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        userCon.clear();
        passCon.clear();
        dispCon = "";
        Map r = jsonDecode(respuesta.body);
        mensaje = r['mensaje'];
        color = Colors.amber;
        break;
    }
  } on Exception catch (e) {
    userCon.clear();
    passCon.clear();
    dispCon = "";
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
    mensaje = "Se capturo la siguiente excepcion\n ${e}";
    color = Colors.amber;
    print(e);
  } finally {
    alertaPersonalizada(context, color, mensaje);
  }
}

//-----------------------------MONITOREO-----------------------------
Future<void> monitoreo(context) async {
  var temp1, temp2, respuesta;
  try {
    http.Response respuesta =
        await http.get(Uri.parse('http://10.254.254.128:5000/monitor'));

    switch (respuesta.statusCode) {
      case 200:
        temp1 = jsonDecode(respuesta.body);
        temp2 = temp1['monitor'];

        valores_nuevos.value = List<dynamic>.generate(temp2.length, (index) {
          return [temp2[index][0], temp2[index][1]];
        });
        break;

      case 400:
        timer?.cancel();
        Map r = jsonDecode(respuesta.body);
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 401:
        timer?.cancel();
        Map r = jsonDecode(respuesta.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon = "";

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 402:
        timer?.cancel();
        Map r = jsonDecode(respuesta.body);
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 403:
        timer?.cancel();
        Map r = jsonDecode(respuesta.body);
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 404:
        timer?.cancel();
        Map r = jsonDecode(respuesta.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon = "";

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 500:
        Map r = jsonDecode(respuesta.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon = "";

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 501:
        Map r = jsonDecode(respuesta.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon = "";

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;
    }
  } on Exception catch (e) {
    alertaPersonalizada(context, Colors.amber, "Error\n${e}");
  } finally {}
}

Future<void> apagar_encender(int index, context) async {
  bool estado;
  var url_enc = Uri.parse("http://10.254.254.128:5000/puerto?comm=encender");
  var url_apa = Uri.parse("http://10.254.254.128:5000/puerto?comm=apagar");
  var resp_apa_enc;
  try {
    estado = lista_p[index][2];
    if (!estado) {
      var obj = jsonEncode({"puerto": index.toString()});
      resp_apa_enc = await http.post(url_enc,
          headers: {"Content-Type": 'application/json'}, body: obj);

      // switch (resp_apa_enc?.statusCode) {
      //   case 200:
      //     alertaPersonalizada(
      //         context, Colors.green, "El puerto se encendio correctamente");
      //     break;
      //   case 400:
      //     alertaPersonalizada(
      //         context, Colors.amber, "Hubo un error al encender el puerto");
      //     break;
      // }
    } else if (estado) {
      var obj = jsonEncode({"puerto": index.toString()});
      resp_apa_enc = await http.post(url_apa,
          headers: {"Content-Type": 'application/json'}, body: obj);

      // switch (resp_apa_enc?.statusCode) {
      //   case 200:
      //     alertaPersonalizada(
      //         context, Colors.green, "El puerto se apago correctamente");
      //     //lista_p[index][2] = !estado;
      //     break;
      //   case 400:
      //     alertaPersonalizada(
      //         context, Colors.amber, "Hubo un error al apagar el puerto");
      //     break;
      // }
    }
  } on Exception catch (e) {
    alertaPersonalizada(
        context, Colors.red, "Error apagar o encender puerto\n${e.toString()}");
  }
}
