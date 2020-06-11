import 'package:alley_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewConvocazioni extends StatefulWidget {
  @override
  _ViewConvocazioniState createState() => _ViewConvocazioniState();
}

class _ViewConvocazioniState extends State<ViewConvocazioni> {
  Map<String, bool> values = {
    'Player 1': true,
    'Player 2': true,
    'Player 3': false,
    'Player 4': false,
    'Player 5': true,
    'Player 6': false,
    'Player 7': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Convocazioni: "),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: values.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: values[key],
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {},
              color: Colors.orangeAccent,
              child: Text('Conferma'),
            ),
          ),
        ],
      ),
    );
  }
}
