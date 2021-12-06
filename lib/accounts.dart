import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list/user_pref.dart';

CollectionReference accounts =
    FirebaseFirestore.instance.collection("accounts");
final _prefs = new UserPref();

Future<void> registerAccount(user, email, context) {
  return accounts.add({
    "user": user,
    "email": email,
  }).then((value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Registro exitoso")));
  }).catchError((error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error")));
  });
}

Future<void> obtenUsuarioCorreo(correo) {
  print(correo);
  return accounts.where('correo', isEqualTo: correo).get().then((value) {
    value.docs.forEach((result) {
      UserPref.guardaID(result.id);
      print(result.id);
      print(result.data());
    });
  }).catchError((error) {
    print("Error al obtener el usuario: $error");
  });
}
