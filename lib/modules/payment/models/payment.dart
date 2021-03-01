class Payment {
  String merchantId;
  String merchantName;
  String merchantLogo;
  int merchantUin;
  String merchantAddress;
  String merchantCity;
  String merchantCountry;
  String merchantPhone;
  String merchantEmail;
  String branchId;
  String posId;
  String customerId;
  String customerName;
  String customerPhone;
  String customerEmail;
  String description;
  double amount;
  double laramanFeeDouble;
  String laramanFeeString;
  double laramanAmount;
  double netAmount;
  String status;
  DateTime createdAt;
  DateTime updateAt;

  Payment(
      this.merchantId,
      this.merchantName,
      this.merchantLogo,
      this.merchantUin,
      this.merchantAddress,
      this.merchantCity,
      this.merchantCountry,
      this.merchantPhone,
      this.merchantEmail,
      this.branchId,
      this.posId,
      this.customerId,
      this.customerName,
      this.customerPhone,
      this.customerEmail,
      this.description,
      this.amount,
      this.laramanFeeDouble,
      this.laramanFeeString,
      this.laramanAmount,
      this.netAmount,
      this.status,
      this.createdAt,
      this.updateAt);

  Payment.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantName = json['merchantName'];
    merchantLogo = json['merchantLogo'];
    merchantUin = json['merchantUin'];
    merchantAddress = json['merchantAddress'];
    merchantCity = json['merchantCity'];
    merchantCountry = json['merchantCountry'];
    merchantPhone = json['merchantPhone'];
    merchantEmail = json['merchantEmail'];
    branchId = json['branchId'];
    posId = json['posId'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    customerEmail = json['customerEmail'];
    description = json['description'];
    amount = json['amount'];
    laramanFeeDouble = json['laramanFeeDouble'];
    laramanFeeString = json['laramanFeeString'];
    laramanAmount = json['laramanAmount'];
    netAmount = json['netAmount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['merchantName'] = this.merchantName;
    data['merchantLogo'] = this.merchantLogo;
    data['merchantUin'] = this.merchantUin;
    data['merchantAddress'] = this.merchantAddress;
    data['merchantCity'] = this.merchantCity;
    data['merchantCountry'] = this.merchantCountry;
    data['merchantPhone'] = this.merchantPhone;
    data['merchantEmail'] = this.merchantEmail;
    data['branchId'] = this.branchId;
    data['posId'] = this.posId;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerPhone'] = this.customerPhone;
    data['customerEmail'] = this.customerEmail;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['laramanFeeDouble'] = this.laramanFeeDouble;
    data['laramanFeeString'] = this.laramanFeeString;
    data['laramanAmount'] = this.laramanAmount;
    data['netAmount'] = this.netAmount;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
