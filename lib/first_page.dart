import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:list/user_pref.dart';
import 'package:list/values/tema.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:list/widgets/notes_card.dart';
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

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  // Lista de notas que se obtiene del frontEnd ( De momento está fija)
  final List<Map<String, dynamic>> notesList = [
    {
      'title': 'Nota 1',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff6270C4)
    },
    {
      'title': 'Nota 2',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consectetur neque nec pulvinar blandit. Donec sed arcu vestibulum, feugiat enim sed, commodo tellus. Nunc id interdum leo. Sed erat orci, porttitor nec ipsum et, egestas efficitur mi. Nulla quam felis, ultrices non efficitur quis, laoreet venenatis augue. Nulla vitae laoreet orci. Vestibulum viverra, urna ullamcorper pretium fermentum, mi mauris convallis tortor, id pulvinar turpis eros vitae metus. In sed urna aliquam, iaculis orci ut, ultrices magna. Praesent eleifend, sem sit amet fringilla dapibus, magna nisl scelerisque tellus, malesuada auctor sapien arcu et magna. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas nisi lectus, commodo in auctor nec, convallis in augue. Duis ornare arcu augue. Donec congue ornare ante, eget mattis velit bibendum at.',
      'color': const Color(0xff5BC475)
    },
    {
      'title': 'Nota 3',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar, ligula nec molestie venenatis, nulla velit rutrum metus, ut pharetra.',
      'color': const Color(0xff00ADB5)
    },
    {
      'title': 'Nota 4',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff5BC475)
    },
    {
      'title': 'Nota 5',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff00ADB5)
    },
    {
      'title': 'Nota 3',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar, ligula nec molestie venenatis, nulla velit rutrum metus, ut pharetra.',
      'color': const Color(0xff00ADB5)
    },
    {
      'title': 'Nota 4',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff5BC475)
    },
    {
      'title': 'Nota 5',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff00ADB5)
    },
    {
      'title': 'Nota 3',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar, ligula nec molestie venenatis, nulla velit rutrum metus, ut pharetra.',
      'color': const Color(0xff00ADB5)
    },
    {
      'title': 'Nota 4',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff5BC475)
    },
    {
      'title': 'Nota 5',
      'date': DateTime.now(),
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis.',
      'color': const Color(0xff00ADB5)
    },
  ];

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
              title: item['title'],
              content: item['content'],
              date: item['date'],
              cardColor: item['color']);
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
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
                        return const NoteModal();
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
        ),
      ),
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
