import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/partita.dart';
import 'package:alley_app/model/user.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/partite_db.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

DateFormat formatter = DateFormat('dd/MM/yy hh:mm');

class ViewCalendario extends StatefulWidget {
  @override
  _ViewCalendarioState createState() => _ViewCalendarioState();
}

class _ViewCalendarioState extends State<ViewCalendario> with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents = [];
  DateTime _selectedDay;
  AnimationController _animationController;
  CalendarController _calendarController;
  User user = getIt<DatabaseService>().currentUser;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();

    // _events = {
    //   _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7', 'Event D8'],
    //   _selectedDay.add(Duration(days: 1)): ['Event A8'],
    //   _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
    // };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Partita>>(
        future: PartiteDb().getPartite(user.idSquadra),
        builder: (context, snapshot) {
          // print('data: ${snapshot.data}');
          // print('error: ${snapshot.error}');
          if (snapshot.hasData) {
            List<Partita> partite = snapshot.data;
            partite.forEach((p) {
              if (_events.containsKey(p.dataEOra) && !_events[p.dataEOra].contains(p)) {
                _events[p.dataEOra].add(p);
              } else {
                _events[p.dataEOra] = [p];
              }
            });
            // print(_events);
            return Scaffold(
              appBar: AppBar(
                title: Text('Calendario'),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildTableCalendar(),
                  SizedBox(height: 16),
                  Expanded(child: _buildEventList()),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'it_IT',
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(
                    formatter.format(event.dataEOra),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    event is Partita ? 'Partita' : 'Allenamento',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(event.luogo),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
