import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list/user_pref.dart';

CollectionReference notes = FirebaseFirestore.instance.collection("notes");

class Nota {
  Note() {}

  Future<void> addNotes(title, content, context) async {
    // Se obtiene el ID del usuario de sharedpreferences
    String userId = await UserPref.getID();
    return notes.add({
      "titulo": title,
      "contenido": content,
      "fecha": DateTime.now(),
      "userId": userId
    }).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Nota agregada")));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error")));
    });
  }

  Future<List<Map<String, dynamic>>> GetUserNotes(BuildContext context) async {
    List<Map<String, dynamic>> notesList = [];
    String userId = await UserPref.getID();
    var querySnapshot = await notes.where("userId", isEqualTo: userId).get();
    for (var queryDocumentSnapchot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapchot.data();
      notesList.add(data);
    }
    return notesList;
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
