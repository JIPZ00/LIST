import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list/user_pref.dart';

CollectionReference notes = FirebaseFirestore.instance.collection("notes");

class Nota {
  Note() {}

  // Función para agregar una nota a firebase
  Future<void> addNotes(title, content, context) async {
    // Se obtiene el ID del usuario de sharedpreferences
    String userId = await UserPref.getID();
    return notes.add({
      "titulo": title,
      "contenido": content,
      "fecha": DateTime.now(),
      "userId": userId
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nota creada correctamente")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al crear la nota")));
    });
  }

  // Función para obtener las notas de un usuario desde firebase
  static Future<List<Map<String, dynamic>>> getUserNotes() async {
    List<Map<String, dynamic>> notesList = [];
    String userId = await UserPref.getID();
    var querySnapshot = await notes
        .where("userId", isEqualTo: userId)
        .orderBy('fecha', descending: true)
        .get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      data["id"] = queryDocumentSnapshot.id;
      notesList.add(data);
    }
    return notesList;
  }

  // Función para editar la nota de un usuario en firebase
  static Future<void> editNote(title, content, context, noteId) async {
    // Se busca el documento que concuerde con el ID y se le actualizan los campos de titulo contenido y fecha
    return notes.doc(noteId).update({
      'titulo': title,
      'contenido': content,
      'fecha': DateTime.now()
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nota guardada correctamente")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al editar la nota")));
    });
  }

  // Función para eliminar la nota de un usuario en firebase
  static Future<void> deleteNote(noteId, context) async {
    // Se busca el documento que concuerde con el ID de la nota y se elimina de la BD
    return notes.doc(noteId).delete().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Nota eliminada")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al eliminar la nota")));
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
