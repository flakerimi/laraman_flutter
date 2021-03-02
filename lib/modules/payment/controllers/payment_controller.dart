import 'package:get/get.dart';
import 'package:laraman/modules/payment/http/payment_service.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/modules/payment/models/user_payment.dart';

class PaymentController extends GetxController {
  Rx<List<UserPayment>> trans = Rx<List<UserPayment>>();
  static PaymentController to = Get.find();

  addTransaction(Payment transaction, double balance) {
    print('c' + balance.toString());
    return PaymentService().savePayment(transaction, balance);
  }

  Future<List<UserPayment>> getUserTransactions() =>
      PaymentService().getUserTransactions();
}
