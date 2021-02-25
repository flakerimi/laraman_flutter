import 'package:get/get.dart';
import 'package:laraman/modules/ledger/http/firebase_service.dart';
import 'package:laraman/modules/ledger/models/ledger.dart';

class LedgerController extends GetxController {
  List<Ledger> _trans = List<Ledger>.from([0, 1, 2, 3]).obs;

  List<Ledger> get trans => _trans;

  set trans(List<Ledger> trans) {
    _trans = trans;
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    getUserTransactions();
    super.onReady();
  }

  addTransaction(Ledger transaction, double balance) {
    return FirebaseService().savePayment(transaction, balance);
  }

  getUserTransactions() async {
    _trans.addAll(await FirebaseService().getUserTransactions());
  }
}
