import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/ledger/models/ledger.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  savePayment(Ledger payment, double balance) {
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
      "branchId": payment.branchId,
      "posId": payment.posId,
      "customerId": payment.customerId,
      "fromFee": payment.laramanFeeDouble,
      "fromFeeStrung": payment.laramanFeeString,
      "fromAmount": payment.amount,
      "fromNetAmount": payment.netAmount,
      "createdAt": DateTime.now(),
    });
    print(payment.customerId);
    var balanceRef = _db.collection('users').doc(payment.customerId);

    batch.update(balanceRef, {"balance": (balance - payment.amount)});

    var user = _db
        .collection('users')
        .doc(payment.customerId)
        .collection('transactions')
        .doc();
    batch.set(user, {
      "merchantId": payment.merchantId,
      "branchId": payment.branchId,
      "posId": payment.posId,
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

  getUserTransactions() {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      return _db
          .collection('users')
          .doc(auth.currentUser.uid)
          .collection('transactions')
          .snapshots()
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
