import 'package:flutter/material.dart';
import 'package:list/values/tema.dart';

class NoteModal extends StatefulWidget {
  const NoteModal({Key? key}) : super(key: key);

  @override
  _NoteModalState createState() => _NoteModalState();
}

class _NoteModalState extends State<NoteModal> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();
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
            decoration: const InputDecoration(labelText: 'Contenido'),
            maxLines: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print ("Nota Agregada");
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nota agregada'),
                      ),
                    );
                  },
                  child: const Text('Aceptar')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar')),
            ],
          )
        ],
      )),
    );
  }
}
