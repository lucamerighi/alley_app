import 'package:alley_app/views/authenticate/view_register.dart';
import 'package:alley_app/views/authenticate/view_sign_in.dart';
import 'package:flutter/material.dart';

class ViewAuthenticate extends StatefulWidget {
  @override
  _ViewAuthenticateState createState() => _ViewAuthenticateState();
}

class _ViewAuthenticateState extends State<ViewAuthenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return ViewSignIn(toggleView: toggleView);
    } else {
      return ViewRegister(toggleView: toggleView);
    }
  }
}
