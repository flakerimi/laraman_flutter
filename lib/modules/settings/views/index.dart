import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/settings/controllers/setting_controller.dart';
import 'package:laraman/partials/header.dart';

import 'edit_profile.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetX<SettingsController>(
                          init: SettingsController(),
                          builder: (_) => Text(
                                _.account.lastName.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              )),
                      Text(
                        '+383 49 424 555',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      isSwitched = true;
                    },
                    activeTrackColor: Colors.yellow,
                    activeColor: Colors.orangeAccent,
                  ),
                  Text(FirebaseAuth.instance.currentUser.phoneNumber,
                      style: TextStyle(fontSize: 16)),
                  Text(FirebaseAuth.instance.currentUser.uid,
                      style: TextStyle(fontSize: 16)),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(EditProfile());
                      },
                      child: Text('Edit Profile'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
