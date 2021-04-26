import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/bills/models/bill.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/modules/payment/models/user_payment.dart';

class BillService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  savePayment(Payment payment, double balance) {
    var batch = _db.batch();
    print(payment.customerId);
    var merchant = _db
        .collection('merchants')
        .doc(payment.merchantId)
        .collection('transactions')
        .doc();
    batch.set(merchant, payment.toJson());
    var laraman = _db.collection('laraman').doc();

    batch.set(laraman, {
      "laramanAmount": payment.laramanAmount,
      "merchantId": payment.merchantId,
      "merchantName": payment.merchantName,
      "merchantLogo": payment.merchantLogo,
      "branchId": payment.branchId,
      "posId": payment.posId,
      "description": payment.description,
      "customerId": payment.customerId,
      "fromFee": payment.laramanFeeDouble,
      "fromFeeStrung": payment.laramanFeeString,
      "fromAmount": payment.amount,
      "fromNetAmount": payment.netAmount,
      "createdAt": DateTime.now(),
    });
    print(payment.amount);
    print(balance);
    var balanceRef = _db.collection('users').doc(payment.customerId);

    batch.update(balanceRef, {"balance": (balance - payment.amount)});

    var user = _db
        .collection('users')
        .doc(payment.customerId)
        .collection('transactions')
        .doc();
    batch.set(user, {
      "merchantId": payment.merchantId,
      "merchantName": payment.merchantName,
      "merchantLogo": payment.merchantLogo,
      "branchId": payment.branchId,
      "posId": payment.posId,
      "description": payment.description,
      "fromAmount": payment.amount,
      "createdAt": DateTime.now(),
    });
    var transRef = _db.collection('transactions').doc();
    batch.set(transRef, payment.toJson());

    return batch.commit().then(
          (data) => Get.snackbar(
            "Thank You!",
            "Your payment has been processed or something",
            snackPosition: SnackPosition.BOTTOM,
            messageText: Column(
              children: [
                Image.asset('assets/images/check.png'),
                Text('Your payment has been processed or something')
              ],
            ),
          ),
        );
  }

  Future<List<Bill>> getBills() async {
    QuerySnapshot qShot = await _db
        .collection('bills')
        .where('userId', isEqualTo: auth.currentUser.uid)
        .orderBy('createdAt', descending: true)
        .get();

    return qShot.docs.map((doc) => Bill.fromJson(doc.data())).toList();
  }

  Future<List<UserPayment>> getPaymentRequests(userId) async {
    QuerySnapshot qShot = await _db
        .collection('payment_requests')
        .where('fromUserId', isEqualTo: auth.currentUser.uid)
        .orderBy('createdAt', descending: true)
        .get();

    return qShot.docs.map((doc) => UserPayment.fromMap(doc.data())).toList();
  }

  sendPaymentRequests(userId) {}
}
