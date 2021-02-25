import 'package:flutter/material.dart';

class RightDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
