import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list/user_pref.dart';

CollectionReference accounts =
    FirebaseFirestore.instance.collection("accounts");

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
  return accounts.where('email', isEqualTo: correo).get().then((value) {
    for( var user in value.docs){
      // Se guarda el ID del usuario en las sharedPreferences de la aplicación
      UserPref.guardaID(user.id);
    }
  }).catchError((error) {
    print("Error al obtener el usuario: $error");
  });
}
