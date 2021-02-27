import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';

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

  sendFriendRequest(phoneController) {
    var fsUser = _db.collection('users');

    fsUser.where('phoneNumber', isEqualTo: phoneController).get().then((value) {
      var snapshot = value.docs[0];
      if (snapshot.exists) {
        var id = snapshot.id;
        var data = snapshot.data();
        var fo = Friend.fromMap(data);
        print(fo.toJson());
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
        fsUser
            .doc(auth.currentUser.uid)
            .collection('friends')
            .doc(id)
            .set(friend.toJson());

        return jsonDecode(
            '{"status":"error","data":"User added successfully"}');
      } else {
        return jsonDecode(
            '{"status":"error","data":"User Not found, check phone number or invite to Laraman"}');
      }
    });
    return "true";
  }
}
