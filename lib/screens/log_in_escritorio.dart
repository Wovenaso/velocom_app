import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:velocom_app/screens/funciones.dart';

class LoginScreenPrueba extends StatefulWidget {
  const LoginScreenPrueba({Key? key}) : super(key: key);

  @override
  State<LoginScreenPrueba> createState() => _LoginScreenPrueba();
}

class _LoginScreenPrueba extends State<LoginScreenPrueba> {
  String placeUsuario = "Usuario";
  String placeContra = "Contraseña";
  String placeDisp = "Dispositivo";
  double margen_l = 20;
  double margen_r = 20;

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1100) {
      margen_l = 400;
      margen_r = 400;
    } else {
      margen_l = 20;
      margen_r = 20;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.red,
        body: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset("images/logovelocom.png"),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 400),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin:
                  EdgeInsets.only(top: 200, left: margen_l, right: margen_r),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 0.1, blurRadius: 5)
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: userCon,
                    decoration: InputDecoration(
                        hintText: "Usuario",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passCon,
                    obscureText: hide,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hide = !hide;
                              });
                            },
                            icon: hide
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        hintText: "Contraseña",
                        prefixIcon: const Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: "Dispositivo",
                        prefixIcon: const Icon(Icons.router),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    hint: const Text("Dispositivo"),
                    items: dispositivos.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dispCon = value.toString();
                        print(dispCon);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 20)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                        inicio_sesion(
                            userCon.text, passCon.text, dispCon, context);
                      },
                      child: const Text("Entrar")),
                ],
              ),
            ),
          ],
        ));
  }
}
