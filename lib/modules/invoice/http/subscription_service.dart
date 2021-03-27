import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';

class SubscriptionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Subscription>> getMySubscriptionsList() async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('subscriptions')
        .get();

    return qShot.docs.map((doc) => Subscription.fromMap(doc.data())).toList();
  }

  Future<List<Subscription>> getSubscriptionsMerchantsList() async {
    QuerySnapshot qShot = await _db
        .collection('merchants')
        .where('allowSubscriptions', isEqualTo: true)
        .get();

    return qShot.docs.map((doc) => Subscription.fromMap(doc.data())).toList();
  }

  Future<List<Subscription>> getSubscriptionRequests() async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('friends')
        .where('status', isEqualTo: 'requested')
        .get();

    return qShot.docs.map((doc) => Subscription.fromMap(doc.data())).toList();
  }

  sendSubscriptionRequest(phoneController) {
    var fsUser = _db.collection('merchants');

    fsUser.where('phoneNumber', isEqualTo: phoneController).get().then((value) {
      var snapshot = value.docs[0];
      if (snapshot.exists) {
        var id = snapshot.id;
        var data = snapshot.data();
        var fo = Subscription.fromMap(data);
        Subscription friend = Subscription(
          status: 'requested',
          customerFirstName: fo.customerFirstName,
          customerLastName: fo.customerLastName,
          dateCreated: Timestamp.now(),
          dateUpdated: Timestamp.now(),
          merchantUid: fo.merchantUid,
          customerUid: id,
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
