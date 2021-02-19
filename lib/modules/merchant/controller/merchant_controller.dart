import 'package:get/get.dart';
import 'package:laraman/modules/merchant/http/merchant_service.dart';

class MerchantController extends GetxController {
  getMerchant(merchantID) {
    return MerchantService().getMerchant(merchantID);
  }
}
