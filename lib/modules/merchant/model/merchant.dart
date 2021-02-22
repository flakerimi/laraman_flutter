class Merchant {
  final businessName;
  final businessNumber;
  final businessType;
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
  final logo;
  final status;
  final tradeName;
  Merchant({
    this.businessName,
    this.address,
    this.businessNumber,
    this.businessType,
    this.city,
    this.country,
    this.dateCreated,
    this.dateUpdated,
    this.email,
    this.fiscalNumber,
    this.phoneNumber,
    this.uniqueIdentificationNumber,
    this.qr,
    this.logo,
    this.status,
    this.tradeName,
  });
  factory Merchant.fromFirestore(Map data) {
    data = data ?? {};
    return Merchant(
      businessName: data['businessName'],
      businessNumber: data['businessNumber'],
      businessType: data['businessType'],
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
      logo: data['logo'],
      status: data['status'],
      tradeName: data['tradeName'],
    );
  }
}
