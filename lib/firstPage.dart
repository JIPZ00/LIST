import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:list/login.dart';
import 'package:list/firstPage.dart';
import 'package:list/values/tema.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:list/values/tema.dart';

import 'models/nota.dart';

class FirstPage extends StatefulWidget {
  static String id = 'first_page;';

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Nota> misNotas = [
    Nota(titulo: 'Titulo 1', contenido: 'Contenido de la nota numero 1'),
    Nota(titulo: 'Titulo 2', contenido: 'Contenido de la nota numero 2'),
    Nota(titulo: 'Titulo 3', contenido: 'Contenido de la nota numero 3'),
    Nota(titulo: 'Titulo 4', contenido: 'Contenido de la nota numero 4'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: TabBarView(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ModalNota();
                        });
                  },
                  child: Icon(Icons.add),
                ),
                Center(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                Icon(Icons.view_list_rounded),
              ],
            ),
            bottomNavigationBar: TabBar(
              indicatorColor: Colors.grey,
              tabs: [
                Tab(
                  icon: Icon(Icons.note_outlined),
                  text: "Notes",
                ),
                Tab(
                  icon: Icon(Icons.calendar_today_rounded),
                  text: "Calendar",
                ),
                Tab(
                  icon: Icon(Icons.view_list_rounded),
                  text: "Things to do",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ModalNota extends StatefulWidget {
  @override
  State<ModalNota> createState() => _ModalNotaState();
}

class _ModalNotaState extends State<ModalNota> {
  final TextEditingController _tituloController = new TextEditingController();
  final TextEditingController _contenidoController =
      new TextEditingController();

  @override
  void dispose() {
    _contenidoController.dispose();
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //height: 300,
      color: blanco,
      child: Form(
          child: Column(
        children: [
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Texto de la nota'),
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
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nota agregada'),
                      ),
                    );
                  },
                  child: Text('Aceptar')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
            ],
          )
        ],
      )),
    );
  }
}

class Note {
  int id;
  String title;
  String content;
  DateTime date_created;
  DateTime date_last_edited;
  Color note_color;
  int is_archived = 0;

  Note(this.id, this.title, this.content, this.date_created,
      this.date_last_edited, this.note_color);

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
//      'id': id,  since id is auto incremented in the database we don't need to send it to the insert query.
      'title': utf8.encode(title),
      'content': utf8.encode(content),
      'date_created': epochFromDate(date_created),
      'date_last_edited': epochFromDate(date_last_edited),
      'note_color': note_color.value,
      'is_archived': is_archived //  for later use for integrating archiving
    };
    if (forUpdate) {
      data["id"] = this.id;
    }
    return data;
  }

// Converting the date time object into int representing seconds passed after midnight 1st Jan, 1970 UTC
  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

  void archiveThisNote() {
    is_archived = 1;
  }
}
