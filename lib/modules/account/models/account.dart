import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String uid;
  final String address;
  final double balance;
  final String city;
  final String country;
  final Timestamp dateCreated;
  final Timestamp dateUpdated;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String qr;
  final String qrSvg;
  final String status;
  final String language;
  final int limit;
  final String timezone;
  final String accountType;

  Account({
    this.language,
    this.limit,
    this.timezone,
    this.accountType,
    this.uid,
    this.address,
    this.balance,
    this.city,
    this.country,
    this.dateCreated,
    this.dateUpdated,
    this.phoneNumber,
    this.qr,
    this.qrSvg,
    this.status,
    this.email,
    this.firstName,
    this.lastName,
  });
  factory Account.fromMap(Map data) {
    return Account(
      language: data['language'],
      limit: int.parse(data['limit']),
      timezone: data['timeZone'],
      accountType: data['accountType'],
      uid: data['uid'],
      address: data['address'],
      balance: data['balance'] == null ? 0.0 : data['balance'].toDouble(),
      city: data['city'],
      country: data['country'],
      dateCreated: data['dateCreated'],
      dateUpdated: data['dateUpdated'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      qr: data['qr'],
      qrSvg: data['qrSvg'],
      status: data['status'],
    );
  }
  factory Account.fromDocumentSnapshot(DocumentSnapshot data) {
    return Account(
      language: data['language'],
      limit: int.parse(data['limit']),
      timezone: data['timeZone'],
      accountType: data['accountType'],
      uid: data['uid'],
      address: data['address'],
      balance: data['balance'] == null ? 0.0 : data['balance'].toDouble(),
      city: data['city'],
      country: data['country'],
      dateCreated: data['dateCreated'],
      dateUpdated: data['dateUpdated'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      qr: data['qr'],
      qrSvg: data['qrSvg'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "limit": limit,
        "timezone": timezone,
        "accountType": accountType,
        "uid": uid,
        "address": address,
        "balance": balance == null ? 0.0 : balance.toDouble(),
        "city": city,
        "country": country,
        "dateCreated": dateCreated,
        "dateUpdated": dateUpdated,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "qr": qr,
        "qrSvg": qrSvg,
        "status": status
      };
}
