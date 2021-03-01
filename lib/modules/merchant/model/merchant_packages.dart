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
}
