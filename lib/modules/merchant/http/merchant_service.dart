import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/merchant/model/merchant_packages.dart';
import 'package:laraman/modules/payment/models/payment.dart';

class MerchantService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  getMerchant(String merchantID) {
    // print("merchantID: " + merchantID);
    try {
      return _db
          .collection('merchants')
          .doc(merchantID)
          .get()
          .then((snapshot) => Merchant.fromFirestore(snapshot.data()));
    } catch (e) {
      print(merchantID);
      print(e.toString());
    }
  }

  Future<List<Merchant>> getSubscriptionsMerchantsList() async {
    QuerySnapshot qShot = await _db
        .collection('merchants')
        .where('allowSubscriptions', isEqualTo: true)
        .get();

    return qShot.docs.map((doc) => Merchant.fromMap(doc.data())).toList();
  }

  Future<List<MerchantPackages>> getMerchantPackages(String merchantId) async {
    print(merchantId);
    QuerySnapshot qShot = await _db
        .collection('merchants')
        .doc(merchantId)
        .collection('subscriptionPackages')
        .get();

    return qShot.docs
        .map((doc) => MerchantPackages.fromMap(doc.data()))
        .toList();
  }

  Future<List<Payment>> getTopThreeMerchants(String uid) async {
    QuerySnapshot data =
        await _db.collection('users').doc(uid).collection('transactions').get();

    // var docs = data.docs.toList();
    return data.docs
        .map((doc) => Payment.fromJson(doc.data()))
        // .toSet()
        .toList();
  }
}
