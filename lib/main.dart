// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:list/user_pref.dart';
import 'package:list/login.dart';
import 'package:list/first_page.dart';
import 'package:list/values/tema.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: miTema(context),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (BuildContext context) => LoginPage(),
        FirstPage.id: (BuildContext context) => FirstPage(),
      },
    );
  }
}
