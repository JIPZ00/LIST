// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:list/first_page.dart';
import 'package:list/values/tema.dart';
import 'package:list/nota.dart';

class NoteModal extends StatefulWidget {
  // Callback que se va a ejecutar cuando se agregue una nueva nota
  final noteCallback;

  // Bandera que determina si se está editando o creando una nota
  final edit;

  // Título de la nota ( En caso de que se esté editando )
  final noteTitle;

  // Texto de la nota ( En caso de que se esté editando )
  final noteContent;

  // Id de la nota ( En caso de que se esté editando )
  final noteId;

  const NoteModal(
      {Key? key,
      this.noteCallback,
      required this.edit,
      this.noteTitle,
      this.noteContent,
      this.noteId})
      : super(key: key);

  @override
  _NoteModalState createState() => _NoteModalState();
}

class _NoteModalState extends State<NoteModal> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();
  final noteController = Nota();

  @override
  void initState() {
    // En caso de que se esté editando la nota entonces se le va a asignar a los controladores del titulo y el contenido de la nota
    // el texto recibido al crear el widget
    if (widget.edit) {
      _tituloController.text = widget.noteTitle;
      _contenidoController.text = widget.noteContent;
    }
    super.initState();
  }

  @override
  void dispose() {
    _contenidoController.dispose();
    _tituloController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // Función para agregar una nueva nota
  createNote(BuildContext context) {
    noteController
        .addNotes(_tituloController.text, _contenidoController.text, context)
        .then((value) {
      Navigator.pop(context);
      widget.noteCallback();
    });
  }

  // Función para editar una nota ya creada
  editNote(BuildContext context) {
    Nota.editNote(_tituloController.text, _contenidoController.text, context,
            widget.noteId)
        .then((value) {
      Navigator.pop(context);
      widget.noteCallback();
    });
  }

  // Función para eliminar una nota
  deleteNote(BuildContext context) {
    Nota.deleteNote(widget.noteId, context).then((value) {
      Navigator.pop(context);
      widget.noteCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //height: 300,
      color: blanco,
      child: Form(
          child: Column(
        children: [
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Titulo de la Nota'),
          ),
          TextFormField(
            controller: _contenidoController,
            decoration: const InputDecoration(labelText: 'Contenido'),
            maxLines: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Guardar Nota'),
                onPressed: () {
                  // Si no se está editando la nota entonces se crea una nueva nota para ese usuario
                  if (!widget.edit) {
                    createNote(context);
                  }
                  // En caso contrario se va a editar la nota ya creada
                  else {
                    editNote(context);
                  }
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Visibility(
                visible: widget.edit,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text('Eliminar Nota'),
                  onPressed: () {
                    deleteNote(context);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      )),
    );
  }
}
