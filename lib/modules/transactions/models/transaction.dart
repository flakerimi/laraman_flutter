class Transaction {
  final merchantId;
  final branchId;
  final posId;
  final double amount;
  final customerId;
  final description;

  Transaction(
    this.merchantId,
    this.branchId,
    this.posId,
    this.amount,
    this.customerId,
    this.description,
  );
  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "branchId": branchId,
        "posId": posId,
        "amount": amount,
        "customerId": customerId,
        "description": description
      };
}
