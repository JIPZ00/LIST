import 'package:flutter/material.dart';
import 'package:list/ForgotPasswordPage.dart';
import 'package:list/login.dart';
import 'package:list/firstPage.dart';
import 'package:list/register.dart';
import 'package:list/user.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = User();

  TextEditingController controlUsuario = TextEditingController();
  Widget userTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controlUsuario,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'User',
          labelText: 'User',
        ),
        onChanged: (value) {},
      ),
    );
  }

  TextEditingController controlPassword = TextEditingController();
  Widget passwordTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controlPassword,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
        ),
        onChanged: (value) {},
      ),
    );
  }

  @override
  /*Widget labelForgotPssw() {
    return Scaffold(
      
    )
  }*/

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
              return new ForgotPasswordPage();
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
              return new RegisterPage();
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('LOGIN'),
          ),
          onPressed: () {
            if (controlUsuario.text != '' && controlPassword.text != '') {
              //Se realiza la consulta para iniciar sesion
              userController
                  .login(controlUsuario.text, controlPassword.text)
                  .then((resp) {
                //Si se logra inciar sesion
                if (resp["ok"] == true) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return new FirstPage();
                      },
                      settings: RouteSettings(name: FirstPage.id)));
                  //Si no
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                    content: Text("Datos incompletos o error."),
                  ));
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text("Datos erroneos."),
              ));
            }
          },
          style: ElevatedButton.styleFrom(primary: Colors.grey),
          //onPressed: (){}
        );
      }
    }

    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*const Image(
                  //image: NetworkImage(''),
                  image: AssetImage('assets\LIST_logo.png'),
                  height: 140,
                ),*/
                Image.asset("assets/LIST_logo.png"),
                const SizedBox(
                  height: 15.0,
                ),
                userTextField(),
                const SizedBox(
                  height: 15,
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
                Text("¿Aún no estás registrado?"),
                registerButton(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
