import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
