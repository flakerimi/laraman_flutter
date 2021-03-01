class Merchant {
  final uid;
  final businessName;
  final businessNumber;
  final businessType;
  final tradeName;
  final address;
  final city;
  final country;
  final dateCreated;
  final dateUpdated;
  final email;
  final fiscalNumber;
  final phoneNumber;
  final uniqueIdentificationNumber;
  final qr;
  final qrSvg;
  final logo;
  final status;
  final feeDouble;
  final feeString;
  Merchant(
      {this.uid,
      this.businessName,
      this.address,
      this.businessNumber,
      this.businessType,
      this.tradeName,
      this.city,
      this.country,
      this.dateCreated,
      this.dateUpdated,
      this.email,
      this.fiscalNumber,
      this.phoneNumber,
      this.uniqueIdentificationNumber,
      this.qr,
      this.qrSvg,
      this.logo,
      this.status,
      this.feeDouble,
      this.feeString});
  factory Merchant.fromFirestore(Map data) {
    data = data ?? {};
    return Merchant(
      uid: data['uid'],
      businessName: data['businessName'],
      businessNumber: data['businessNumber'],
      businessType: data['businessType'],
      tradeName: data['tradeName'],
      address: data['address'],
      city: data['city'],
      country: data['country'],
      dateCreated: data['dateCreated'],
      dateUpdated: data['dateUpdated'],
      email: data['email'],
      fiscalNumber: data['fiscalNumber'],
      phoneNumber: data['phoneNumber'],
      uniqueIdentificationNumber: data['uniqueIdentificationNumber'],
      qr: data['qr'],
      qrSvg: data['qrSvg'],
      logo: data['logo'],
      status: data['status'],
      feeDouble: data['feeDouble'],
      feeString: data['feeString'],
    );
  }
  factory Merchant.fromMap(Map data) {
    data = data ?? {};
    return Merchant(
      uid: data['uid'],
      businessName: data['businessName'],
      businessNumber: data['businessNumber'],
      businessType: data['businessType'],
      tradeName: data['tradeName'],
      address: data['address'],
      city: data['city'],
      country: data['country'],
      dateCreated: data['dateCreated'],
      dateUpdated: data['dateUpdated'],
      email: data['email'],
      fiscalNumber: data['fiscalNumber'],
      phoneNumber: data['phoneNumber'],
      uniqueIdentificationNumber: data['uniqueIdentificationNumber'],
      qr: data['qr'],
      qrSvg: data['qrSvg'],
      logo: data['logo'],
      status: data['status'],
      feeDouble: data['feeDouble'],
      feeString: data['feeString'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['businessName'] = this.businessName;
    data['businessNumber'] = this.businessNumber;
    data['businessType'] = this.businessType;
    data['tradeName'] = this.tradeName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['email'] = this.email;
    data['fiscalNumber'] = this.fiscalNumber;
    data['phoneNumber'] = this.phoneNumber;
    data['uniqueIdentificationNumber'] = this.uniqueIdentificationNumber;
    data['qr'] = this.qr;
    data['qrSvg'] = this.qrSvg;
    data['logo'] = this.logo;
    data['status'] = this.status;
    data['feeDouble'] = this.feeDouble;
    data['feeString'] = this.feeString;
    return data;
  }
}
