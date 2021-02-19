import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/settings/controllers/setting_controller.dart';
import 'package:laraman/modules/settings/http/account_service.dart';
import 'package:laraman/modules/settings/models/account.dart';
import 'package:laraman/modules/settings/views/edit_profile.dart';

import 'package:laraman/partials/header.dart';

class LoginView extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  void verifyPhone() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          UserCredential result = await _auth.signInWithCredential(credential);

          User user = result.user;
          bool isNew = result.additionalUserInfo.isNewUser;
          if (user != null) {
            if (isNew) {
              print('New user 1' + isNew.toString());

              var fsUser = FirebaseFirestore.instance.collection('users');
              Account account = Account(
                  uid: user.uid,
                  phoneNumber: user.phoneNumber,
                  firstName: 'FLakerim');
              fsUser.doc(user.uid).set(account.toJson());
              Get.to(EditProfile());
            } else {
              Get.put(SettingsController()).account = await AccountService()
                  .getAccount(FirebaseAuth.instance.currentUser.uid);
              Get.to(HomeView());
            }
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          Get.dialog(AlertDialog(
            title: Text("Give the code?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Confirm"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  final code = _codeController.text;
                  AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: code);

                  UserCredential result =
                      await _auth.signInWithCredential(credential);
                  bool isNew = result.additionalUserInfo.isNewUser;

                  User user = result.user;

                  if (user != null) {
                    if (isNew) {
                      print('New user 2' + isNew.toString());
                      var fsUser =
                          FirebaseFirestore.instance.collection('users');
                      Account account = Account(
                        uid: user.uid,
                        phoneNumber: user.phoneNumber,
                      );
                      fsUser.doc(user.uid).set(account.toJson());
                      Get.to(EditProfile());
                    } else {
                      Get.to(HomeView());
                    }
                  } else {
                    print("Error");
                  }
                },
              )
            ],
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  signInWithOTP(smsCode, verificationId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            //  Avatar(controller.firestoreUser.value),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    decoration: InputDecoration(
                        filled: false,
                        icon: Icon(Icons.phone),
                        fillColor: Colors.indigo, //Palette.inputFillColor,
                        labelText: '+383',
                        hintText: '49123456'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: ElevatedButton(
                    onPressed: () {
                      verifyPhone();
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo, padding: EdgeInsets.all(20)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
