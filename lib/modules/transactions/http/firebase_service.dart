import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  savePayment(payment) {
    return _db.collection('transactions').add(payment);
  }
}
