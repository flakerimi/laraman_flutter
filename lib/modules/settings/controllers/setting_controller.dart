import 'package:get/get.dart';
import 'package:laraman/modules/settings/models/account.dart';

class SettingsController extends GetxController {
  Rx<Account> _accountModel = Account().obs;

  Account get account => _accountModel.value;

  set account(Account value) => this._accountModel.value = value;

  void clear() {
    _accountModel.value = Account();
  }
}
