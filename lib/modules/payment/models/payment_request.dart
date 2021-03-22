import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentRequest {
  final String toUserId;
  final String fromUserId;
  final double fromAmount;
  final bool status;
  final Timestamp createdAt;
  final String posId;
  final String merchantName;
  final String merchantLogo;
  final String merchantId;
  final String description;
  final String branchId;

  PaymentRequest({
    this.toUserId,
    this.fromUserId,
    this.status,
    this.posId,
    this.merchantName,
    this.merchantLogo,
    this.merchantId,
    this.fromAmount,
    this.description,
    this.createdAt,
    this.branchId,
  });

  factory PaymentRequest.documentSnapshot(DocumentSnapshot data) {
    return PaymentRequest(
      toUserId: data['toUserId'],
      posId: data['posId'],
      merchantName: data['merchantName'],
      merchantLogo: data['merchantLogo'],
      merchantId: data['merchantId'],
      fromUserId: data['fromUserId'],
      fromAmount: data['fromAmount'],
      description: data['description'],
      createdAt: data['createdAt'],
      branchId: data['branchId'],
    );
  }
  factory PaymentRequest.fromMap(Map data) {
    return PaymentRequest(
      toUserId: data['toUserId'],
      posId: data['posId'],
      merchantName: data['merchantName'],
      merchantLogo: data['merchantLogo'],
      merchantId: data['merchantId'],
      fromUserId: data['fromUserId'],
      fromAmount: data['fromAmount'],
      description: data['description'],
      createdAt: data['createdAt'],
      branchId: data['branchId'],
    );
  }
  Map<String, dynamic> toJson() => {
        "toUserId": toUserId,
        "posId": posId,
        "merchantName": merchantName,
        "merchantLogo": merchantLogo,
        "merchantId": merchantId,
        "fromUserId": fromUserId,
        "fromAmount": fromAmount,
        "description": description,
        "createdAt": createdAt,
        "branchId": branchId,
      };
}
