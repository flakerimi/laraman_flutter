import 'package:cloud_firestore/cloud_firestore.dart';

class UserLedger {
  final String branchId;
  final String merchantId;
  final String merchantName;
  final String merchantLogo;
  final String posId;
  final String description;
  final Timestamp createdAt;
  final double fromAmount;

  UserLedger(
      {this.branchId,
      this.merchantId,
      this.merchantName,
      this.merchantLogo,
      this.description,
      this.posId,
      this.createdAt,
      this.fromAmount});

  factory UserLedger.fromMap(Map data) {
    return UserLedger(
        branchId: data['branchId'],
        merchantId: data['merchantId'],
        merchantName: data['merchantName'],
        merchantLogo: data['merchantLogo'],
        description: data['description'],
        posId: data['posId'],
        createdAt: data['createdAt'],
        fromAmount: data['fromAmount']);
  }
  factory UserLedger.documentSnapshot(DocumentSnapshot data) {
    return UserLedger(
        branchId: data['branchId'],
        merchantId: data['merchantId'],
        merchantName: data['merchantName'],
        merchantLogo: data['merchantLogo'],
        description: data['description'],
        posId: data['posId'],
        createdAt: data['createdAt'],
        fromAmount: data['fromAmount']);
  }
}
