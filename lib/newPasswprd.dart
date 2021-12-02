import 'package:flutter/material.dart';
import 'package:list/login.dart';
import 'package:list/recoverySuccessful.dart';

class newPasswordPage extends StatefulWidget {
  static String id = 'newpass_page';

  @override
  _newPasswordPageState createState() => _newPasswordPageState();
}

class _newPasswordPageState extends State<newPasswordPage> {
  TextEditingController passwUser = TextEditingController();
  Widget passwordTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: passwUser,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Nueva Contraseña',
          labelText: 'Nueva Contraseña',
        ),
        onChanged: (value) {},
      ),
    );
  }

  TextEditingController newPasswUser = TextEditingController();
  Widget newPasswordTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: newPasswUser,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Confirmar Contraseña',
          labelText: 'Confirmar Contraseña',
        ),
        onChanged: (value) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget recoveryButtom() {
      return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Recuperar contraseña'),
        ),
        onPressed: () {
          if (newPasswUser.text == '' || passwUser.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content:
                  Text("Ingrese contraseñas y verifique que sean iguales."),
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return new RecoverySuccessfulPage();
                },
                settings: RouteSettings(name: RecoverySuccessfulPage.id)));
          }
        },
        style: ElevatedButton.styleFrom(primary: Colors.grey),
        //onPressed: (){}
      );
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text('Crear nueva contraseña'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    passwordTextField(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    newPasswordTextField(),
                    const SizedBox(
                      height: 100.0,
                    ),
                    recoveryButtom(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
