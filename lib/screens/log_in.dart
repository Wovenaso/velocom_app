import 'package:flutter/material.dart';
import 'package:velocom_app/screens/funciones.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String placeUsuario = "Usuario";
  String placeContra = "Contraseña";
  String placeDisp = "Dispositivo";

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.red,
        body: Stack(
          children: [
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
              margin: const EdgeInsets.only(top: 200, left: 400, right: 400),
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
              child: FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
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
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          hintText: "Contraseña",
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),    
                    TextField(
                      controller: dispCon,
                      decoration: InputDecoration(
                          hintText: "Dispositivo",
                          prefixIcon: const Icon(Icons.router),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                          inicio_sesion(
                              userCon.text, passCon.text, dispCon.text, context);
                        },
                        child: const Text("Entrar")),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 10,
                left: 425,
                child: Image.asset("images/logovelocom.png",
                    width: 400, height: 200))
          ],
        ));
  }
}
