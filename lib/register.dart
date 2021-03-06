import 'package:flutter/material.dart';
import 'package:list/accounts.dart';
import 'package:list/login.dart';
import 'package:list/registerSuccessful.dart';
import 'package:list/user.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = User();

  TextEditingController nameUser = TextEditingController();
  Widget userTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: nameUser,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'User',
          labelText: 'User',
        ),
        onChanged: (value) {},
      ),
    );
  }

  TextEditingController emailUser = TextEditingController();
  Widget emailTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: emailUser,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Correo electronico',
          labelText: 'Correo electronico',
        ),
        onChanged: (value) {},
      ),
    );
  }

  TextEditingController passwordUser = TextEditingController();
  Widget psswTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: passwordUser,
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

  TextEditingController confirmPassword = TextEditingController();
  Widget cPasswTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: confirmPassword,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Confirma contraseña',
          labelText: 'Confirma contraseña',
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget loginButton() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle:
            const TextStyle(fontSize: 15, decoration: TextDecoration.underline),
        primary: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return new LoginPage();
            },
            settings: RouteSettings(name: LoginPage.id)));
      },
      child: const Text('Inicia sesion'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget registerButtom() {
      return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('REGISTRATE'),
        ),
        onPressed: () {
          if (nameUser.text == '' ||
              emailUser.text == '' ||
              passwordUser.text == '' ||
              confirmPassword.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: Text("Datos incompletos."),
            ));
          } else {
            userController.RegisterUser(emailUser.text, passwordUser.text)
                .then((value) {
              if (value["Ok"] == true) {
                registerAccount(nameUser.text, emailUser.text, context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return new RegisterSuccessfulPage();
                    },
                    settings: RouteSettings(name: RegisterSuccessfulPage.id)));
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(primary: Colors.grey),
        //onPressed: (){}
      );
    }

    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                userTextField(),
                const SizedBox(
                  height: 15.0,
                ),
                emailTextField(),
                const SizedBox(
                  height: 15.0,
                ),
                psswTextField(),
                const SizedBox(
                  height: 15.0,
                ),
                cPasswTextField(),
                const SizedBox(
                  height: 20,
                ),
                registerButtom(),
                const SizedBox(
                  height: 50,
                ),
                Text("¿Ya estás registrado?"),
                loginButton(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
