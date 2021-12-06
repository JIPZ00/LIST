import 'package:flutter/material.dart';
import 'package:list/ForgotPasswordPage.dart';
import 'package:list/accounts.dart';
import 'package:list/first_page.dart';
import 'package:list/register.dart';
import 'package:list/user.dart';
import 'package:list/values/tema.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = User();

  TextEditingController controlUsuario = TextEditingController();
  Widget userTextField() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controlUsuario,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onChanged: (value) {},
      ),
    );
  }

  TextEditingController controlPassword = TextEditingController();
  Widget passwordTextField() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controlPassword,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget forgotPassword() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle:
            const TextStyle(fontSize: 15, decoration: TextDecoration.underline),
        primary: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return ForgotPasswordPage();
            },
            settings: RouteSettings(name: ForgotPasswordPage.id)));
      },
      child: const Text('Olvidé mi contraseña'),
    );
  }

  Widget registerButton() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle:
            const TextStyle(fontSize: 15, decoration: TextDecoration.underline),
        primary: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return RegisterPage();
            },
            settings: RouteSettings(name: RegisterPage.id)));
      },
      child: const Text('Registrate aquí'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bottonLogin() {
      {
        return ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryBlueColor)),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text('LOGIN', style: TextStyle(fontSize: 18)),
          ),
          onPressed: () {
            if (controlUsuario.text != '' && controlPassword.text != '') {
              //Se realiza la consulta para iniciar sesion
              userController
                  .login(controlUsuario.text, controlPassword.text)
                  .then((resp) {
                //Si se logra inciar sesion
                if (resp["ok"] == true) {
                  obtenUsuarioCorreo(controlUsuario.text).then((value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const FirstPage();
                        },
                        settings: RouteSettings(name: FirstPage.id)));
                  });
                  //Si no
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Datos incompletos o error."),
                  ));
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Datos erroneos."),
              ));
            }
          },
          //onPressed: (){}
        );
      }
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundPageColor,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 120,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text('Correo Electrónico'),
                    const SizedBox(
                      height: 5,
                    ),
                    userTextField(),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Contraseña'),
                    const SizedBox(
                      height: 5,
                    ),
                    passwordTextField(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    forgotPassword(),
                    const SizedBox(
                      height: 20,
                    ),
                    bottonLogin(),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("¿Aún no estás registrado?"),
                    registerButton(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
