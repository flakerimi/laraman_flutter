import 'package:get/get.dart';
import 'package:laraman/modules/bills/http/bill_service.dart';

class BillController extends GetxController {
  static BillController to = Get.find();

  getBills() {
    BillService().getBills();
  }
}
