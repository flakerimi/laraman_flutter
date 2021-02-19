import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';

class MerchantService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  getMerchant(merchantID) {
    return _db
        .collection('merchants')
        .doc(merchantID)
        .snapshots()
        .map((snapshot) => Merchant.fromFirestore(snapshot.data()));
  }
}
