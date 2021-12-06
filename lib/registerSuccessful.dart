import 'package:flutter/material.dart';
import 'package:list/register.dart';
import 'package:list/login.dart';
import 'package:list/values/tema.dart';

class RegisterSuccessfulPage extends StatefulWidget {
  static String id = 'register_successful_page';

  @override
  _RegisterSuccessfulPageState createState() => _RegisterSuccessfulPageState();
}

class _RegisterSuccessfulPageState extends State<RegisterSuccessfulPage> {
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
          Text("Registro Exitoso"),
          Icon(
            Icons.check,
            size: 60,
          ),
          Text("Puedes iniciar secion con tus nuevos datos"),
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
