import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  final String uid;
  final String status;
  final String address;
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

  Friend({
    this.uid,
    this.status,
    this.address,
    this.city,
    this.country,
    this.dateCreated,
    this.dateUpdated,
    this.phoneNumber,
    this.qr,
    this.qrSvg,
    this.email,
    this.firstName,
    this.lastName,
  });
  factory Friend.fromMap(Map data) {
    return Friend(
      uid: data['uid'],
      address: data['address'],
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
  factory Friend.fromDocumentSnapshot(DocumentSnapshot data) {
    return Friend(
      uid: data['uid'],
      address: data['address'],
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
        "status": status,
        "address": address,
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
      };
}
