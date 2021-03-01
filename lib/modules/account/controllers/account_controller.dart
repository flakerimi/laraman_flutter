import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/models/account.dart';
import 'package:laraman/modules/ledger/controllers/ledger_controller.dart';

class AccountController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  static AccountController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxBool isLogged = false.obs;
  Rx<User> firebaseUser = Rx<User>();
  Rx<Account> account = Rx<Account>();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);

    Get.put<LedgerController>(LedgerController());

    super.onReady();
  }

  Future<User> get getUser async => _auth.currentUser;
  Stream<User> get user => _auth.authStateChanges();
  Stream<Account> streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (firebaseUser?.value?.uid != null) {
      return _db
          .collection('users')
          .doc(firebaseUser.value.uid)
          .snapshots()
          .map((snapshot) => Account.fromMap(snapshot.data()));
      //fsUser.then((value) => {print(value.country)});
    }

    return null;
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      account.bindStream(streamFirestoreUser());
    }

    if (_firebaseUser == null) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/home");
    }
  }

  void verifyPhone(_phoneController, codeController) async {
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
              Get.toNamed("/edit-profile");
            } else {
              Get.toNamed("/home");
            }
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String _verificationId, [int forceResendingToken]) {
          verifyCode(_verificationId, codeController);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  verifyCode(_verificationId, _codeController) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.indigo,
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
          textColor: Colors.indigo,
          color: Colors.white,
          onPressed: () async {
            final code = _codeController.text;
            AuthCredential credential = PhoneAuthProvider.credential(
                verificationId: _verificationId, smsCode: code);

            UserCredential result =
                await _auth.signInWithCredential(credential);
            bool isNew = result.additionalUserInfo.isNewUser;

            User user = result.user;

            if (user != null) {
              if (isNew) {
                print('New user 2' + isNew.toString());
                var fsUser = FirebaseFirestore.instance.collection('users');
                Account account = Account(
                  uid: user.uid,
                  phoneNumber: user.phoneNumber,
                );
                fsUser.doc(user.uid).set(account.toJson());
                Get.toNamed("/edit-profile");
              } else {
                Get.toNamed("/home");
              }
            } else {
              print("Error");
            }
          },
        )
      ],
    ));
  }
}
