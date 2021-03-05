class MerchantPackages {
  final description;
  final durationString;
  final durationTime;
  final name;
  final price;
  final currency;
  MerchantPackages(
      {this.description,
      this.durationString,
      this.durationTime,
      this.name,
      this.price,
      this.currency});
  factory MerchantPackages.fromFirestore(Map data) {
    data = data ?? {};
    return MerchantPackages(
        description: data['description'],
        durationString: data['durationString'],
        durationTime: data['durationTime'],
        name: data['name'],
        price: data['price'],
        currency: data['currency']);
  }
  factory MerchantPackages.fromMap(Map data) {
    data = data ?? {};
    return MerchantPackages(
        description: data['description'],
        durationString: data['durationString'],
        durationTime: data['durationTime'],
        name: data['name'],
        price: data['price'],
        currency: data['currency']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['description'] = this.description;
    data['durationString'] = this.durationString;
    data['durationTime'] = this.durationTime;
    data['name'] = this.name;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}
