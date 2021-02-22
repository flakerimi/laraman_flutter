import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';

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
}
