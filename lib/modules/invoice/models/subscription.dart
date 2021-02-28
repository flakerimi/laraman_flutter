import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  final String status;
  final String subscriptionName;
  final String subscriptionDescription;
  final String subscriptionDurationString;
  final String subscriptionDurationTime;
  final String subscriptionPrice;
  final String subscriptionCurrency;
  final Timestamp dateCreated;
  final Timestamp dateUpdated;
  final String customerUid;
  final String customerFirstName;
  final String customerLastName;
  final String customerPhoneNumber;
  final String merchantUid;
  final String merchantBusinessName;
  final String merchantBusinessLogo;
  final String merchantUin;

  Subscription({
    this.customerUid,
    this.customerFirstName,
    this.customerLastName,
    this.customerPhoneNumber,
    this.merchantUid,
    this.merchantBusinessName,
    this.merchantBusinessLogo,
    this.merchantUin,
    this.subscriptionName,
    this.subscriptionDescription,
    this.subscriptionDurationString,
    this.subscriptionDurationTime,
    this.subscriptionPrice,
    this.subscriptionCurrency,
    this.status,
    this.dateCreated,
    this.dateUpdated,
  });
  factory Subscription.fromMap(Map data) {
    return Subscription(
      customerUid: data['customerUid'],
      customerFirstName: data['customerFirstName'],
      customerLastName: data['customerLastName'],
      customerPhoneNumber: data['customerPhoneNumber'],
      merchantUid: data['merchantUid'],
      merchantBusinessName: data['merchantBusinessName'],
      merchantBusinessLogo: data['merchantBusinessLogo'],
      merchantUin: data['merchantUin'],
      subscriptionName: data['subscriptionName'],
      subscriptionDescription: data['subscriptionDescription'],
      subscriptionDurationString: data['subscriptionDurationString'],
      subscriptionDurationTime: data['subscriptionDurationTime'],
      subscriptionPrice: data['subscriptionPrice'],
      subscriptionCurrency: data['subscriptionCurrency'],
      status: data['status'],
      dateCreated: data['dateCreated'],
      dateUpdated: data['dateUpdated'],
    );
  }
  factory Subscription.fromDocumentSnapshot(DocumentSnapshot data) {
    return Subscription(
      customerUid: data['customerUid'],
      customerFirstName: data['customerFirstName'],
      customerLastName: data['customerLastName'],
      customerPhoneNumber: data['customerPhoneNumber'],
      merchantUid: data['merchantUid'],
      merchantBusinessName: data['merchantBusinessName'],
      merchantBusinessLogo: data['merchantBusinessLogo'],
      merchantUin: data['merchantUin'],
      subscriptionName: data['subscriptionName'],
      subscriptionDescription: data['subscriptionDescription'],
      subscriptionDurationString: data['subscriptionDurationString'],
      subscriptionDurationTime: data['subscriptionDurationTime'],
      subscriptionPrice: data['subscriptionPrice'],
      subscriptionCurrency: data['subscriptionCurrency'],
      status: data['status'],
      dateCreated: data['dateCreated'],
      dateUpdated: data['dateUpdated'],
    );
  }

  Map<String, dynamic> toJson() => {
        "customerUid": customerUid,
        "customerFirstName": customerFirstName,
        "customerLastName": customerLastName,
        "customerPhoneNumber": customerPhoneNumber,
        "merchantUid": merchantUid,
        "merchantBusinessName": merchantBusinessName,
        "merchantBusinessLogo": merchantBusinessLogo,
        "merchantUin": merchantUin,
        "subscriptionName": subscriptionName,
        "subscriptionDescription": subscriptionDescription,
        "subscriptionDurationString": subscriptionDurationString,
        "subscriptionDurationTime": subscriptionDurationTime,
        "subscriptionPrice": subscriptionPrice,
        "subscriptionCurrency": subscriptionCurrency,
        "status": status,
        "dateCreated": dateCreated,
        "dateUpdated": dateUpdated,
      };
}
