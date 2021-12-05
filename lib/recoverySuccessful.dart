import 'package:flutter/material.dart';
import 'package:list/register.dart';
import 'package:list/login.dart';
import 'package:list/ForgotPasswordPage.dart';
import 'package:list/values/tema.dart';

class RecoverySuccessfulPage extends StatefulWidget {
  static String id = 'recovery_successful_page';

  @override
  _RecoverySuccessfulPageState createState() => _RecoverySuccessfulPageState();
}

class _RecoverySuccessfulPageState extends State<RecoverySuccessfulPage> {
  @override
  build(BuildContext context) {
    //return message(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            message(context),
            Image.asset(
              "assets/logo.png",
              height: 120,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }

  Card message(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Correo de recuperación enviado"),
          Icon(
            Icons.email,
            size: 60,
          ),
          Text(
              "Se ha enviado la información para recuperar su contraseña al correo que proporcionó, verifique la información. En caso de que no encuentre el correo verifique su carpeta de SPAM"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new LoginPage();
                            },
                            settings: RouteSettings(name: LoginPage.id))),
                      },
                  child: Text('Regresar al inicio'),
                  style: ElevatedButton.styleFrom(primary: primaryBlueColor))
            ],
          )
        ],
      ),
    );
  }
}
