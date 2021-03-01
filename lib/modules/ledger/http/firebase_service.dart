import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/ledger/models/ledger.dart';
import 'package:laraman/modules/ledger/models/user_ledger.dart';

class FirebaseService {
  AccountController auth = Get.find<AccountController>();

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

  Stream<List<UserLedger>> getUserTransactions() {
    return _db
        .collection('users')
        .doc(auth.firebaseUser.value.uid)
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot qShot) {
      List<UserLedger> retVal = List();
      qShot.docs.forEach((element) {
        retVal.add(UserLedger.documentSnapshot(element));
      });
      return retVal;
    });
  }
}
