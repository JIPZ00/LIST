import 'package:flutter/material.dart';
import 'package:list/login.dart';
import 'package:list/recoverySuccessful.dart';
import 'package:list/values/tema.dart';

class ForgotPasswordPage extends StatefulWidget {
  static String id = 'register_successful_page';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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

  @override
  Widget build(BuildContext context) {
    Widget recoveryButtom() {
      return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Recuperar contraseña'),
        ),
        onPressed: () {
          if (emailUser.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content:
                  Text("Ingrese correo electronico para recuperar contraseña."),
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return new RecoverySuccessfulPage();
                },
                settings: RouteSettings(name: RecoverySuccessfulPage.id)));
          }
        },
        style: ElevatedButton.styleFrom(primary: primaryBlueColor),
        //onPressed: (){}
      );
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryBlueColor,
            title: Text('Recuperar Contraseña'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    emailTextField(),
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
