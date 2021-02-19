import 'package:get/get.dart';
import 'package:laraman/modules/transactions/http/firebase_service.dart';

class TransactionController extends GetxController {
  addTransaction(transaction) {
    FirebaseService().savePayment(transaction);
  }
}
