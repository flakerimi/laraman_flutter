import 'package:get/get.dart';
import 'package:laraman/modules/ledger/http/firebase_service.dart';
import 'package:laraman/modules/ledger/models/ledger.dart';

class LedgerController extends GetxController {
  addTransaction(Ledger transaction, double balance) {
    return FirebaseService().savePayment(transaction, balance);
  }
}
