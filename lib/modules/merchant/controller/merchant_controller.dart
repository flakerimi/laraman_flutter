import 'package:get/get.dart';
import 'package:laraman/modules/merchant/http/merchant_service.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';

class MerchantController extends GetxController {
  Future<Merchant> getMerchant(String merchantID) {
    return MerchantService().getMerchant(merchantID);
  }
}
