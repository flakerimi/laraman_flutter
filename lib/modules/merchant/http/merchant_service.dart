import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/merchant/model/merchant_packages.dart';

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
    QuerySnapshot qShot = await _db
        .collection('merchants')
        .doc(merchantId)
        .collection('subscriptionPackages')
        .get();

    return qShot.docs
        .map((doc) => MerchantPackages.fromMap(doc.data()))
        .toList();
  }
}
