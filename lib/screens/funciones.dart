import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocom_app/screens/log_in.dart';
import 'dart:convert';

import 'package:velocom_app/screens/movil_screen.dart';
import 'package:velocom_app/screens/widgets/dialogoPer.dart';

TextEditingController userCon = TextEditingController();
TextEditingController passCon = TextEditingController();
TextEditingController dispCon = TextEditingController();

String tipo = '';
List<dynamic> lista_p = [];
List<dynamic> valores = [];
String usuario_activo = "";

final valores_nuevos = ValueNotifier<List<dynamic>>([0, 0]);

Future<void> inicio_sesion(
    String user, String pass, String disp, context) async {
  print(user);
  print(pass);
  print(disp);

  var url = Uri.parse("http://192.168.20.196:5000/inicio");
  var respuesta;

  try {
    var obj =
        jsonEncode({'nombre_disp': disp, 'usuario': user, 'contra': pass});

    respuesta = await http.post(url,
        headers: {"Content-Type": 'application/json'}, body: obj);
  } on Exception catch (e) {
    userCon.clear();
    passCon.clear();
    dispCon.clear();
    print(e);

    alertaPersonalizada(context, Colors.amber, "La API no esta funcionando");
  } finally {
    print(respuesta?.statusCode);
    switch (respuesta?.statusCode) {
      case 200:
        Map r = jsonDecode(respuesta?.body);

        usuario_activo = user;

        lista_p.clear();
        valores_nuevos.value.clear();

        tipo = r['tipo'];
        lista_p = r['puertos'];

        valores = List<dynamic>.generate(lista_p.length, (i) {
          return [0, 0];
        });

        valores_nuevos.value = List<dynamic>.generate(lista_p.length, (index) {
          return [0, 0];
        });

        userCon.clear();
        passCon.clear();
        dispCon.clear();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MovilScreen(),
            ));
        break;

      case 403:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon.clear();
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;

      case 405:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon.clear();
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;

      case 406:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon.clear();
        Navigator.of(context).pop();
        alertaPersonalizada(context, Colors.amber, r['mensaje']);
        break;
      case 500:
        Map r = jsonDecode(respuesta.body);
        userCon.clear();
        passCon.clear();
        dispCon.clear();
        Navigator.of(context).pop();
        r['mensaje'];
        break;
    }
  }
}

Future<void> cerrar_sesion(context) async {
  var url = Uri.parse("http://192.168.20.196:5000/cerrar");
  var respuesta;

  try {
    respuesta = await http.get(url);
  } on Exception catch (e) {
    alertaPersonalizada(context, Colors.red, "Error\n${e}");
  } finally {
    if (respuesta?.statusCode == 200) {
      lista_p.clear();
      valores.clear();
      valores_nuevos.value.clear();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
      userCon.clear();
      passCon.clear();
      dispCon.clear();
      alertaPersonalizada(context, Colors.green, "Se cerro la sesion");
    }
  }

  // if (usuario_activo.isEmpty) {
  //   alertaPersonalizada(context, Colors.amber, "No hay usuario conectado");
  //   lista_p.clear();
  //   valores.clear();
  //   valores_nuevos.value.clear();
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreen(),
  //       ));
  //   userCon.clear();
  //   passCon.clear();
  //   dispCon.clear();
  // }

  // try {
  //   var obj = jsonEncode({'usuario': usuario_activo});

  //   respuesta = await http.post(url,
  //       headers: {"Content-Type": 'application/json'}, body: obj);
  // } on Exception catch (e) {
  //   userCon.clear();
  //   passCon.clear();
  //   dispCon.clear();
  //   alertaPersonalizada(
  //       context, Colors.amber, "Se capturo la siguiente excepcion\n ${e}");
  //   print(e);

  //   alertaPersonalizada(context, Colors.amber, "La API no esta funcionando");
  // } finally {
  //   switch (respuesta?.statusCode) {
  //     case 200:
  //       lista_p.clear();
  //       valores.clear();
  //       valores_nuevos.value.clear();
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const LoginScreen(),
  //           ));
  //       userCon.clear();
  //       passCon.clear();
  //       dispCon.clear();
  //       alertaPersonalizada(
  //           context, Colors.green, "Se cerro la sesion adecuadamente");
  //       break;
  //     case 400:
  //       lista_p.clear();
  //       valores.clear();
  //       valores_nuevos.value.clear();
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const LoginScreen(),
  //           ));
  //       userCon.clear();
  //       passCon.clear();
  //       dispCon.clear();
  //       Map r = jsonDecode(respuesta.body);
  //       alertaPersonalizada(
  //           context, Colors.green, "Se detecto un error al cerrar la sesion\nMensaje: ${r['mensaje']}");
  //       break;
  // }
  //}
}

Future<void> monitoreo(context) async {
  var temp1, temp2, respuesta;
  try {
    http.Response respuesta =
        await http.get(Uri.parse('http://192.168.20.196:5000/monitor'));
  } on Exception catch (e) {
    alertaPersonalizada(context, Colors.amber, "Error\n${e}");
  } finally {
    // TODO
    switch (respuesta?.statusCode) {
      case 200:
        temp1 = jsonDecode(respuesta?.body);
        temp2 = temp1['monitor'];

        valores_nuevos.value = List<dynamic>.generate(temp2.length, (index) {
          return [temp2[index][0], temp2[index][1]];
        });
        break;

      case 400:
        Map r = jsonDecode(respuesta?.body);
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 401:
        Map r = jsonDecode(respuesta?.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon.clear();

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
        Map r = jsonDecode(respuesta?.body);
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 403:
        Map r = jsonDecode(respuesta?.body);
        alertaPersonalizada(
          context,
          Colors.red,
          r['mensaje'],
        );
        break;

      case 500:
        Map r = jsonDecode(respuesta?.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon.clear();

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
        Map r = jsonDecode(respuesta?.body);
        lista_p.clear();
        valores.clear();
        valores_nuevos.value.clear();

        userCon.clear();
        passCon.clear();
        dispCon.clear();

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
  }
}

Future<void> apagar_encender(int index, context) async {
  bool estado;
  var url_enc = Uri.parse("http://192.168.20.196:5000/puerto?comm=encender");
  var url_apa = Uri.parse("http://192.168.20.196:5000/puerto?comm=apagar");
  var resp_apa_enc;
  try {
    estado = lista_p[index][2];
    if (!estado) {
      var obj = jsonEncode({"puerto": index.toString()});
      resp_apa_enc = await http.post(url_enc,
          headers: {"Content-Type": 'application/json'}, body: obj);

      switch (resp_apa_enc?.statusCode) {
        case 200:
          alertaPersonalizada(
              context, Colors.green, "El puerto se encendio correctamente");
          break;
        case 400:
          alertaPersonalizada(
              context, Colors.amber, "Hubo un error al encender el puerto");
          break;
      }
    } else if (estado) {
      var obj = jsonEncode({"puerto": index.toString()});
      resp_apa_enc = await http.post(url_apa,
          headers: {"Content-Type": 'application/json'}, body: obj);

      switch (resp_apa_enc?.statusCode) {
        case 200:
          alertaPersonalizada(
              context, Colors.green, "El puerto se apago correctamente");
          //lista_p[index][2] = !estado;
          break;
        case 400:
          alertaPersonalizada(
              context, Colors.amber, "Hubo un error al apagar el puerto");
          break;
      }
    }
  } on Exception catch (e) {
    alertaPersonalizada(context, Colors.red, "Error apagar o encender puerto\n${e.toString()}");
  }
}



// Future inicio(user, pass, disp, context) async {
//   var url = Uri.parse("http://10.254.255.101:5000/inicio");
//   var response;

//   print(user);
//   print(pass);
//   print(disp);

//   if (user != "") {
//     if (pass != "") {
//       if (disp != "") {
//         try {
//           var obj = jsonEncode(
//               {'nombre_disp': disp, 'usuario': user, 'contra': pass});

//           response = await http.post(url,
//               headers: {"Content-Type": 'application/json'}, body: obj);
//         } on Exception catch (e) {
//           // TODO
//           userCon.clear();
//           passCon.clear();
//           dispCon.clear();
//           Navigator.of(context).pop();
//           //dialogo(1, "La API no esta funcionando", context);
//         } finally {
//           print(response?.statusCode);

//           switch (response?.statusCode) {
//             case 200:
//               Map r = jsonDecode(response?.body);

//               lista_p.clear();
//               valores.clear();
//               valores_nuevos.value.clear();

//               tipo = r['tipo'];
//               lista_p = r['puertos'];

//               valores = List<dynamic>.generate(lista_p.length, (i) {
//                 return [0, 0];
//               });

//               valores_nuevos.value =
//                   List<dynamic>.generate(lista_p.length, (index) {
//                 return [0, 0];
//               });

//               print(valores.length);
//               userCon.clear();
//               passCon.clear();
//               dispCon.clear();
//               Navigator.of(context).pop();
//               Navigator.pushReplacement(
//                   context,
//                   mat.MaterialPageRoute(
//                     builder: (context) => const NavigationScreen(),
//                   ));
//               break;

//             case 403:
//               userCon.clear();
//               passCon.clear();
//               dispCon.clear();
//               Navigator.of(context).pop();
//               dialogo(2, "No se encontro el dispositivo", context);
//               break;

//             case 405:
//               userCon.clear();
//               passCon.clear();
//               dispCon.clear();
//               Navigator.of(context).pop();
//               dialogo(1, "Error con el usuario y/o contraseña", context);
//               break;

//             case 406:
//               userCon.clear();
//               passCon.clear();
//               dispCon.clear();
//               Navigator.of(context).pop();
//               dialogo(
//                   1, "No se logro conectar al dispositivo ingresado", context);

//               break;
//           }
//         }
//       } else {
//         Navigator.of(context).pop();
//         dialogo(2, "Ingrese un usuario", context);
//       }
//     } else {}
//   } else {
//     Navigator.of(context).pop();
//     dialogo(2, "Ingrese un dispositivo para conectarse", context);
//   }
// }
