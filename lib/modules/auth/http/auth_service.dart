import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/home/views/index.dart';

class AuthService {
  String phoneNo;
  String smsCode;
  String verificationId;
//Handles Auth
  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    /* if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      Get.offAll(SignInUI());
    } else {
      Get.offAll(HomeUI());
    } */
  }
  /* Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (firebaseUser?.value?.uid != null) {
      return _db
          .doc('/users/${firebaseUser.value.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data()));
    }

    return null;
  } */
  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  } // SignIn

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signInWithOTP(smsCode, verificationId) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((value) => Get.to(HomeView()))
        .catchError((e) => print(e));
  }
}
