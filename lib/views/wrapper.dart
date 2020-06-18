import 'package:alley_app/model/user.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/views/authenticate/view_authenticate.dart';
import 'package:alley_app/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fbuser = Provider.of<FirebaseUser>(context);
    if (fbuser == null) {
      return ViewAuthenticate();
    } else {
      return FutureProvider<User>(
        create: (context) => getIt<DatabaseService>().getUser(fbuser.uid),
        child: Home(),
      );
    }
  }
}
