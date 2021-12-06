import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference notes = FirebaseFirestore.instance.collection("notes");

class Nota {
  Note() {}

  Future<void> addNotes(title, content, context) {
    return notes.add({
      "titulo": title,
      "contenido": content,
      "fecha": DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Nota agregada")));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    });
  }
}

/*
class Nota {
  Nota({
    this.titulo,
    this.contenido,
    this.key,
  });
  String? titulo;
  String? contenido;
  String? key;
}
*/
