import 'package:cloud_firestore/cloud_firestore.dart';

class UserPayment {
  final String branchId;
  final String merchantId;
  final String merchantName;
  final String merchantLogo;
  final String posId;
  final String description;
  final Timestamp createdAt;
  final double fromAmount;

  UserPayment(
      {this.branchId,
      this.merchantId,
      this.merchantName,
      this.merchantLogo,
      this.description,
      this.posId,
      this.createdAt,
      this.fromAmount});

  factory UserPayment.fromMap(Map data) {
    return UserPayment(
        branchId: data['branchId'],
        merchantId: data['merchantId'],
        merchantName: data['merchantName'],
        merchantLogo: data['merchantLogo'],
        description: data['description'],
        posId: data['posId'],
        createdAt: data['createdAt'],
        fromAmount: data['fromAmount']);
  }
  factory UserPayment.documentSnapshot(DocumentSnapshot data) {
    return UserPayment(
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
