import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;
  final Color cardColor;
  // Constructor que recibe el titulo de la nota, el contenido y la fecha
  const NoteCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.date,
      required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 10,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fecha de la nota
              Expanded(
                  flex: 1,
                  child: Text(DateFormat('dd-MM-yyyy').format(date),
                      style: const TextStyle(
                          color: Color(0xffFFFFFF), fontSize: 16))),
              // Titulo de la nota
              Expanded(
                  flex: 2,
                  child: Text(title,
                      style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.w600))),
              // Contenido
              Expanded(
                  flex: 7,
                  child: Text(content,
                      maxLines: 5,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xffFFFFFF),
                          fontSize: 14))),
            ],
          ),
        ));
  }
}
