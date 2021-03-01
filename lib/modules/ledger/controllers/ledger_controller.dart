import 'package:get/get.dart';
import 'package:laraman/modules/ledger/http/firebase_service.dart';
import 'package:laraman/modules/ledger/models/ledger.dart';
import 'package:laraman/modules/ledger/models/user_ledger.dart';

class LedgerController extends GetxController {
  Rx<List<UserLedger>> trans = Rx<List<UserLedger>>();

  @override
  void onReady() {
    // called after the widget is rendered on screen
    // trans.bindStream(getUserTransactions());
    super.onReady();
  }

  addTransaction(Ledger transaction, double balance) {
    return FirebaseService().savePayment(transaction, balance);
  }

  Stream<List<UserLedger>> getUserTransactions() =>
      FirebaseService().getUserTransactions();
}
