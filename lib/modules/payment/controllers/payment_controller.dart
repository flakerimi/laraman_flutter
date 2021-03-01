import 'package:get/get.dart';
import 'package:laraman/modules/payment/http/payment_service.dart';
import 'package:laraman/modules/payment/models/Payment.dart';
import 'package:laraman/modules/payment/models/user_payment.dart';

class PaymentController extends GetxController {
  Rx<List<UserPayment>> trans = Rx<List<UserPayment>>();

  @override
  void onReady() {
    // called after the widget is rendered on screen
    trans.bindStream(getUserTransactions());
    super.onReady();
  }

  addTransaction(Payment transaction, double balance) {
    return PaymentService().savePayment(transaction, balance);
  }

  Stream<List<UserPayment>> getUserTransactions() =>
      PaymentService().getUserTransactions();
}
