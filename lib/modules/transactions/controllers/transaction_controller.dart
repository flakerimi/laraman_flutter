import 'package:get/get.dart';
import 'package:laraman/modules/transactions/http/firebase_service.dart';
import 'package:laraman/modules/transactions/models/transaction.dart';

class TransactionController extends GetxController {
  addTransaction(LaramanTransaction transaction) {
    return FirebaseService().savePayment(transaction);
  }
}
