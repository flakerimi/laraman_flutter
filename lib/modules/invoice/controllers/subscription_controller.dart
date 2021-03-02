import 'package:get/get.dart';
import 'package:laraman/modules/subscription/http/subscription_service.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController to = Get.find();

  final status = 'accepted';

  Future<List<Subscription>> getMySubscriptions() async {
    return await SubscriptionService().getMySubscriptionsList();
  }

  Future<List<Subscription>> getSubscriptionsMerchantsList() async {
    return await SubscriptionService().getSubscriptionsMerchantsList();
  }

  static makeRequest(_phoneController) async {
    var message =
        await SubscriptionService().sendSubscriptionRequest(_phoneController);
    Get.back();
    print(message);
    return message;
  }
}
