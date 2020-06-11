import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Color(0xffF1EFF1),
      child: Center(
        // child: SpinKitWanderingCubes(
        //   color: Colors.orange,
        //   size: 50.0,
        // ),
        child: Image.asset(
          "assets/loading.gif",
        ),
      ),
    );
  }
}
