import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laraman/partials/header.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            VerticalDivider(),
            VerticalDivider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                VerticalDivider(),
                Text('Welcome', style: TextStyle(fontSize: 16)),
                VerticalDivider(),
                Text(FirebaseAuth.instance.currentUser.phoneNumber,
                    style: TextStyle(fontSize: 16)),
                VerticalDivider(),
                Text(FirebaseAuth.instance.currentUser.uid,
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            VerticalDivider(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(40),
              ),
              child: Text(
                "PAY",
                style: TextStyle(fontSize: 30),
              ),
            ),
            VerticalDivider(),
          ],
        ),
      ),
    );
  }
}
