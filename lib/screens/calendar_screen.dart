import 'package:flutter/material.dart';
import 'package:pmsna1/models/event_model.dart';
import 'package:pmsna1/screens/list_tasks.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import '../database/database_helper.dart';

class TwoViewsButton extends StatefulWidget {
  @override
  _TwoViewsButtonState createState() => _TwoViewsButtonState();
}

class _TwoViewsButtonState extends State<TwoViewsButton> {
  DatabaseHelper? database;
  EventModel? objEventModel;
  bool _showFirstView = true;
  DateTime today = DateTime.now();
  Map<DateTime, List> events = {};
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
    _loadAllEvents();
  }

  void _onSelection(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      
    });
  }

  _loadAllEvents() async {
    List<EventModel> loadedEvents =
        (await database!.GET_ALL_EVENTOS()).cast<EventModel>();
    setState(() {
      events = {};
      for (EventModel event in loadedEvents) {
        DateTime eventDate = DateTime.parse(event.fechaEvento!);
        if (events[eventDate] == null) {
          events[eventDate] = [event];
        } else {
          events[eventDate]!.add(event);
        }
      }
    });
  }

  List _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  _addEvent() async {
    String eventName = _eventNameController.text;
    String eventDescription = _eventDescriptionController.text;
    if (eventName.isEmpty || eventDescription.isEmpty) return;

    EventModel event = EventModel(
      ttlEvento: eventName,
      dscEvento: eventDescription,
      fechaEvento: today.toString(),
      completado: true,
    );
    await database?.INSERT_EVENTO({
      'ttlEvento': event.ttlEvento,
      'dscEvento': event.dscEvento,
      'fechaEvento': event.fechaEvento
    });
    _loadAllEvents();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de actividades'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showFirstView = !_showFirstView;
              });
            },
            child: Icon(_showFirstView
                ? Icons.calendar_today
                : Icons.calendar_view_week_sharp),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _showFirstView ? _buildFirstView() : _buildSecondView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _eventNameController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    TextField(
                      controller: _eventDescriptionController,
                      decoration: InputDecoration(labelText: 'Descripción'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _addEvent();
                        _eventNameController.clear();
                        _eventDescriptionController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Evento agregado con éxito'),
                                duration: Duration(seconds: 2)));
                      },
                      child: Text('Agregar'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildFirstView() {
    return TableCalendar(
        locale: "en_US",
        rowHeight: 60,
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) => isSameDay(day, today),
        onDaySelected: _onSelection,
        eventLoader: _getEventsForDay,
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            BoxDecoration? decoration;
            TextStyle? textStyle;
            int daysDifference = date.difference(DateTime.now()).inDays;
            // print(daysDifference);
            // print(date);
            if (events.isNotEmpty) {
              EventModel eventito = events[0] as EventModel;
              bool? completado = eventito.completado;
              if (daysDifference == 0) {
                // Event is today
                decoration = const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                );
                textStyle = const TextStyle(color: Colors.white);
              } else if (daysDifference == 1 || daysDifference == 2) {
                // Event is in 1 or 2 days
                decoration = const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.yellow,
                );
              } else if (daysDifference < 0 ) {
                // Event has passed and not completed
                decoration = const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.red,
                );
                textStyle = const TextStyle(color: Colors.white);
              }
            }
            return Container(
              width: 22,
              height: 22,
              decoration: decoration,
              child: Center(
                child: Text(events.isNotEmpty ? '${date.day}' : '',
                    style: textStyle),
              ),
            );
          },
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 30));
  }

  Widget _buildSecondView() {
    return Column(
      children: [
        ListTasks()
      ],
    );
  }
}
