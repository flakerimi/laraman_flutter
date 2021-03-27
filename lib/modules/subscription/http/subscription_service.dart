import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';
import 'package:laraman/modules/subscription/views/index.dart';

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

  sendSubscriptionRequest(Subscription data) {
    var batch = _db.batch();

    var merchant = _db
        .collection('merchants')
        .doc(data.merchantUid)
        .collection('subscriptions')
        .doc();
    batch.set(merchant, data.toJson());
    var user = _db
        .collection('users')
        .doc(data.customerUid)
        .collection('subscriptions')
        .doc();
    batch.set(user, data.toJson());
    print("added");
    return batch.commit().then((data) {
      Get.snackbar(
        "Thank You!",
        "You have subscribed to merchant",
        snackPosition: SnackPosition.BOTTOM,
        messageText: Column(
          children: [Text('Your payment has been processed or something')],
        ),
      );
      Get.to(() => SubscriptionIndex());
    });
  }
}
