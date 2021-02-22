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

  Account({
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
      uid: data['uid'],
      address: data['address'],
      balance: data['balance'].toDouble(),
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
      uid: data['uid'],
      address: data['address'],
      balance: data['balance'].toDouble(),
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
        "uid": uid,
        "address": address,
        "balance": balance.toDouble(),
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
