// import 'package:alley_app/services/auth.dart';
// import 'package:alley_app/shared/tile.dart';
// import 'package:alley_app/views/informazioni/home_informazioni.dart';
// import 'package:alley_app/views/squadra/home_squadra.dart';
// import 'package:flutter/material.dart';

// class HomeCoach extends StatelessWidget {
//   final AuthService _auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         title: Text(
//           'Home',
//         ),
//         actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async => await _auth.signOut())],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Tile(
//               imageUrl: 'assets/team.png',
//               text: 'Gestisci Squadra',
//               target: HomeSquadra(),
//             ),
//             SizedBox(height: 40),
//             Tile(
//               imageUrl: 'assets/info.png',
//               text: 'Informazioni',
//               target: HomeInformazioni(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
