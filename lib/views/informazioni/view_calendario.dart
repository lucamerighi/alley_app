import 'package:alley_app/model/allenamento.dart';
import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/partita.dart';
import 'package:alley_app/model/user.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/eventi_db.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/services/turnocibo_db.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateFormat formatter = DateFormat('dd/MM/yy HH:mm');

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
  TurnoCiboDbService turnoCiboDbService = getIt<TurnoCiboDbService>();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
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
    return FutureBuilder<List<Evento>>(
        future: getIt<EventiDbService>().getEventi(user.idSquadra),
        builder: (context, snapshot) {
          // print('data: ${snapshot.data}');
          // print('error: ${snapshot.error}');
          if (snapshot.hasData) {
            List<Evento> eventi = snapshot.data;
            eventi.forEach((e) {
              if (_events.containsKey(e.day) && !_events[e.day].contains(e)) {
                _events[e.day].add(e);
              } else {
                _events[e.day] = [e];
              }
            });
            print(_events);
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
                  color: Colors.orange[200],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(
                    event.dataEOra != null ? formatter.format(event.dataEOra) : 'Data assente',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: event is Partita
                      ? Text('PARTITA', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))
                      : Text('ALLENAMENTO', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  subtitle: Text(event.luogo),
                  onTap: () => _showEventDetail(event),
                ),
              ))
          .toList(),
    );
  }

  _showEventDetail(event) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: event is Partita ? _buildPartita(event) : _buildAllenamento(event),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildPartita(Partita p) {
    return [
      Text('Partita', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      Text(
        '${formatter.format(p.dataEOra)} ${p.luogo}',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 20),
      Text(
        '${p.casa.nome} ${p.casa.punti > 0 ? p.casa.punti : ""}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Text('vs'),
      Text(
        '${p.ospite.nome} ${p.ospite.punti > 0 ? p.ospite.punti : ""}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      SizedBox(height: 20),
      Text('Turno cibo: ${p.getTurnoCibo(user.idSquadra).isNotEmpty ? p.getTurnoCibo(user.idSquadra) : 'nessuno'}'),
      SizedBox(height: 20),
      _showButton(user, p),
    ];
  }

  List<Widget> _buildAllenamento(Allenamento a) {
    return [
      Text('Allenamento', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      Text(
        '${formatter.format(a.dataEOra)} ${a.luogo}',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 20),
      Text('Turno cibo: ${a.turnoCibo.isNotEmpty ? a.turnoCibo : 'nessuno'}'),
      _showButton(user, a),
    ];
  }

  Widget _showButton(User u, Evento e) {
    return RaisedButton(
      color: Colors.orangeAccent,
      onPressed: () {
        e.isMyTurnoCibo(u) ? turnoCiboDbService.removeTurnoCibo(user, e) : turnoCiboDbService.insertTurnoCibo(user, e);
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: e.isMyTurnoCibo(u) ? 'Turno cibo inserito' : 'Turno cibo eliminato',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      child: e.isMyTurnoCibo(u) ? Text('Lascio il turno cibo') : Text('Porto io il cibo!'),
    );
  }
}
