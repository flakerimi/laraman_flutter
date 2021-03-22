import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/models/friend.dart';

class FriendService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Friend>> getFriendsList() async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('friends')
        .where('status', isEqualTo: 'accepted')
        .get();

    return qShot.docs.map((doc) => Friend.fromMap(doc.data())).toList();
  }

  Future<List<Friend>> getFriendRequests() async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('friends')
        .where('status', isEqualTo: 'requested')
        .get();

    return qShot.docs.map((doc) => Friend.fromMap(doc.data())).toList();
  }

  Future<Friend> getFriendByPhoneNumber(phoneController) async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneController)
        .get();

    return Friend.fromMap(qShot.docs.first.data()); //((doc) =>  doc.data());
  }

  sendFriendRequest(phoneController) {
    var fsUser = _db.collection('users');
    //print(phoneController);
    fsUser.where('phoneNumber', isEqualTo: phoneController).get().then((value) {
      // print(value.docs.length);
      if (value.docs.length != 0) {
        var snapshot = value.docs[0];
        var id = snapshot.id;
        var data = snapshot.data();
        var fo = Friend.fromMap(data);
        // print(fo.toJson());
        Friend friend = Friend(
          status: 'requested',
          firstName: fo.firstName,
          lastName: fo.lastName,
          dateCreated: Timestamp.now(),
          dateUpdated: Timestamp.now(),
          phoneNumber: fo.phoneNumber,
          email: fo.email,
          uid: id,
          address: fo.address,
          city: fo.city,
          country: fo.country,
          qr: fo.qr,
          qrSvg: fo.qr,
        );
        print(friend.firstName);
        return friend;
      } else {
        Get.snackbar("User not exist", 'message');
      }
    });
  }

  saveFriendRequest(Friend friend) {
    var fsUser = _db.collection('users');

    fsUser
        .doc(auth.currentUser.uid)
        .collection('friends')
        .doc(friend.uid)
        .set(friend.toJson());
  }

  sendMoney(double amount) {
    print(amount);
  }

  requestMoney(double amount) {
    print(amount);
  }
}
