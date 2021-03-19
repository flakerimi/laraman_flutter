import 'package:get/get.dart';
import 'package:laraman/modules/merchant/http/merchant_service.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/merchant/model/merchant_packages.dart';
import 'package:laraman/modules/payment/models/payment.dart';

class MerchantController extends GetxController {
  static MerchantController to = Get.find();

  Future<Merchant> getMerchant(String merchantID) {
    return MerchantService().getMerchant(merchantID);
  }

  Future<List<Payment>> getTopThreeMerchants(String uid) {
    return MerchantService().getTopThreeMerchants(uid);
  }

  Future<List<Merchant>> getSubscriptionMerchant() {
    return MerchantService().getSubscriptionsMerchantsList();
  }

  Future<List<MerchantPackages>> getMerchantPackages(merchantId) {
    return MerchantService().getMerchantPackages(merchantId);
  }
}
