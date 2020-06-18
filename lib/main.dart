import 'package:alley_app/model/user.dart';
import 'package:alley_app/services/auth.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/views/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting('it_IT').then((_) {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alley App',
        theme: ThemeData(
          fontFamily: 'Raleway',
          scaffoldBackgroundColor: Colors.orange[100],
          backgroundColor: Colors.orange[100],
          accentColor: Colors.orangeAccent,
          appBarTheme: AppBarTheme(
            color: Colors.orange[400],
            elevation: 5,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
