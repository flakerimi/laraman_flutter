class Transaction {
  final merchantId;
  final branchId;
  final posId;
  final amount;
  final customerID;

  Transaction(
    this.merchantId,
    this.branchId,
    this.posId,
    this.amount,
    this.customerID,
  );
  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "branchId": branchId,
        "posId": posId,
        "amount": amount,
        "customerID": customerID,
      };
}
