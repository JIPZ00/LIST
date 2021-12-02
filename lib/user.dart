import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  var _token = "AIzaSyBXW8mb8BJpoGC-06WeY6z6G8k8dLlbTKo";

  User() {}

  Future<Map<String, dynamic>> RegisterUser(email, paswrord) async {
    final datos = {
      "email": email,
      "password": paswrord,
      "returnSecureToken": true
    };
    final respuesta = await http.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_token"),
        body: json.encode(datos));
    Map<String, dynamic> respuestaDeco = json.decode(respuesta.body);
    if (respuestaDeco.containsKey("idToken")) {
      return {
        "Ok": true,
        "Token": respuestaDeco["idToken"],
      };
    } else {
      return {
        "Ok": false,
      };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final datos = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      Uri.parse(
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_token"),
      body: json.encode(datos),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if (decodedResp.containsKey('idToken')) {
      return {
        'ok': true,
        'token': decodedResp['idToken'],
      };
    } else {
      return {
        'ok': false,
      };
    }
  }
}
