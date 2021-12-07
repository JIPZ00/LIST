// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:list/nota.dart';
import 'package:list/user_pref.dart';
import 'package:list/values/tema.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:list/widgets/notes_card.dart';
import 'dart:math';

// import 'models/nota.dart';
import 'package:list/widgets/note_modal.dart';

class FirstPage extends StatefulWidget {
  static String id = 'first_page;';

  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int tabIndex = 0;

  List<Map<String, dynamic>> notesList = [];

  Future<List<Map<String, dynamic>>> future = Nota.getUserNotes();
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  // Función para obtener un color de manera aleatoria
  Color getColor() {
    var rng = Random();
    var colorNumber = rng.nextInt(2);
    if (colorNumber == 0) {
      return const Color(0xff6270C4);
    } else {
      return const Color(0xff5BC475);
    }
  }

  // Función para obtener el widget con la sección de notas
  Widget getNotesSection(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(11.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
        itemCount: notesList.length,
        itemBuilder: (BuildContext context, index) {
          final item = notesList[index];
          return NoteCard(
            title: item['titulo'],
            content: item['contenido'],
            date: item['fecha'].toDate(),
            cardColor: getColor(),
            index: index,
            callbackNoteClick: callbackNoteClick,
          );
        });
  }

  // Función para obtener el widget con la sección de calendario
  Widget getCalendarSection(BuildContext context) {
    return Center(
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
    );
  }

  // Función para obtener el widget con la sección de tareas
  Widget getToDoSection(BuildContext context) {
    return const Center(child: Text('Sección de tareas'));
  }

// Función para obtener el scaffold de la pagina
  Widget getPageScaffold() {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: backgroundPageColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryBlueColor,
        child: const Icon(Icons.add, color: primaryWhite, size: 30.0),
        onPressed: () {
          switch (_tabController.index) {
            // El indice está en la pantalla de notas
            case 0:
              print("Creando nueva nota");
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return NoteModal(
                        edit: false, noteCallback: callbackNewNote);
                  });
              break;
            // El índice está en la pantalla del calendario
            case 1:
              print("Creando nuevo evento");
              break;
            case 2:
              // El índice está en la pantalla de cosas x hacer
              print("Creando nueva tarea");
              break;
          }
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          getNotesSection(context),
          getCalendarSection(context),
          getToDoSection(context),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: primaryBlueColor,
        labelColor: primaryBlueColor,
        unselectedLabelColor: unselectedOptionColor,
        tabs: const [
          Tab(
            icon: Icon(Icons.note_outlined, size: 30.0),
            text: "Notes",
          ),
          Tab(
            icon: Icon(Icons.calendar_today_rounded, size: 30.0),
            text: "Calendar",
          ),
          Tab(
            icon: Icon(Icons.view_list_rounded, size: 30.0),
            text: "Things to do",
          ),
        ],
      ),
    );
  }

  // Función para obtener el widget con la animación de carga
  Widget getFetchAnimation() {
    return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
      strokeWidth: 3,
    )));
  }

// Función que devuelve la pantalla con un mensaje de error en caso de que no se haya podido obtener la información del usuario
  Widget getErrorMessage() {
    return const Scaffold(
        body: const Center(
            child: Padding(
      padding: EdgeInsets.all(8.0),
      child: const Text(
        'Error al obtener la información del usuario',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.red),
      ),
    )));
  }

  // Método Callback que se dispara cuando el usuario guarde una nueva nota
  callbackNewNote() {
    print("Cambió la lista de notas");
    setState(() {
      future = Nota.getUserNotes();
    });
  }
  // Método callback que se dispara cuando el usuario de click a una nota ya creada
  callbackNoteClick(int index){
    print("Nota seleccionada: "+ notesList[index].toString());
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
          child: FutureBuilder<List<Map<String, dynamic>>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            notesList = snapshot.data!;
            return getPageScaffold();
          } else if (snapshot.hasError) {
            return getErrorMessage();
          } else {
            return getFetchAnimation();
          }
        },
      )),
    );
  }
}

// class Note {
//   int id;
//   String title;
//   String content;
//   DateTime date_created;
//   DateTime date_last_edited;
//   Color note_color;
//   int is_archived = 0;

//   Note(this.id, this.title, this.content, this.date_created,
//       this.date_last_edited, this.note_color);

//   Map<String, dynamic> toMap(bool forUpdate) {
//     var data = {
// //      'id': id,  since id is auto incremented in the database we don't need to send it to the insert query.
//       'title': utf8.encode(title),
//       'content': utf8.encode(content),
//       'date_created': epochFromDate(date_created),
//       'date_last_edited': epochFromDate(date_last_edited),
//       'note_color': note_color.value,
//       'is_archived': is_archived //  for later use for integrating archiving
//     };
//     if (forUpdate) {
//       data["id"] = this.id;
//     }
//     return data;
//   }

// // Converting the date time object into int representing seconds passed after midnight 1st Jan, 1970 UTC
//   int epochFromDate(DateTime dt) {
//     return dt.millisecondsSinceEpoch ~/ 1000;
//   }

//   void archiveThisNote() {
//     is_archived = 1;
//   }
// }
