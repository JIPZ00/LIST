import 'package:flutter/material.dart';
import 'package:list/register.dart';
import 'package:list/login.dart';
import 'package:list/values/tema.dart';

class NewPasswordSuccessfulPage extends StatefulWidget {
  static String id = 'newpass_successful_page';

  @override
  _NewPasswordSuccessfulPageState createState() =>
      _NewPasswordSuccessfulPageState();
}

class _NewPasswordSuccessfulPageState extends State<NewPasswordSuccessfulPage> {
  @override
  build(BuildContext context) {
    //return message(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Crear nueva contraseña'),
        ),
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
          Text("Recuperación de contraseña exitosa"),
          Icon(
            Icons.check,
            size: 60,
          ),
          Text(
              "Se ha cambiado con éxito tu contraseña, ahora puedes iniciar sesión con tu nueva contraseña"),
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
                  style: ElevatedButton.styleFrom(
                    primary: primaryBlueColor
                  ))
            ],
          )
        ],
      ),
    );
  }
}
