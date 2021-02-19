import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<AccountController>(AccountController(), permanent: true);
  }
}
