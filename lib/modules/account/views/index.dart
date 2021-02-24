import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/settings/http/account_service.dart';
import 'package:laraman/modules/account/models/account.dart';
import 'package:laraman/modules/settings/views/edit_profile.dart';

class LoginView extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final myFocusNode = FocusNode();

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
              Get.find<AccountController>().account = await AccountService()
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
                      Get.find<AccountController>().account =
                          await AccountService().getAccount(
                              FirebaseAuth.instance.currentUser.uid);
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
    //FocusScope.of(context).unfocus();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            VerticalDivider(),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/l.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'LARAMAN',
                  style: GoogleFonts.rubik(
                    fontSize: 48,
                    color: Colors.indigo,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            VerticalDivider(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Shkruani numrin e telefonit dhe shtypeni buttonin login. Pas pak do te pranoni nje sms me kod, qe do ta shkruani ketu per tu loguar.',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextFormField(
                    controller: _phoneController,
                    autofocus: true,
                    focusNode: myFocusNode,
                    decoration: new InputDecoration(
                      labelText: "Shkruaj numrin e telefonit",
                      hintText: '+38349123456',
                      fillColor: Colors.green,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(30)),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    splashColor: Colors.green,
                    icon: Icon(Icons.keyboard_arrow_right_rounded),
                    onPressed: () {
                      verifyPhone();
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
