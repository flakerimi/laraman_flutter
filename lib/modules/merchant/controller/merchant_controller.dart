import 'package:get/get.dart';
import 'package:laraman/modules/merchant/http/merchant_service.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/merchant/model/merchant_packages.dart';

class MerchantController extends GetxController {
  Future<Merchant> getMerchant(String merchantID) {
    return MerchantService().getMerchant(merchantID);
  }

  Future<List<Merchant>> getSubscriptionMerchant() {
    return MerchantService().getSubscriptionsMerchantsList();
  }

  Future<List<MerchantPackages>> getMerchantPackages(merchantId) {
    return MerchantService().getMerchantPackages(merchantId);
  }
}
