import 'package:flutter/material.dart';
import 'package:list/first_page.dart';
import 'package:list/values/tema.dart';
import 'package:list/nota.dart';

class NoteModal extends StatefulWidget {
  const NoteModal({Key? key}) : super(key: key);

  @override
  _NoteModalState createState() => _NoteModalState();
}

class _NoteModalState extends State<NoteModal> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();
  final noteController = Nota();
  @override
  void dispose() {
    _contenidoController.dispose();
    _tituloController.dispose();
    // TODO: implement dispose
    super.dispose();
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
                child: const Text('Aceptar'),
                onPressed: () {
                  noteController
                      .addNotes(_tituloController.text,
                          _contenidoController.text, context)
                      .then((value) {
                    Navigator.pop(context);
                  });

                  // Navigator.pop(context);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text("Nota agregada"),
                  //   ),
                  // );
                },
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
