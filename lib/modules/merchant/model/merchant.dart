class Merchant {
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
      {this.businessName,
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
}
