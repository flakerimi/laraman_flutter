import 'package:get/get.dart';
import 'package:laraman/modules/announcement/http/announcement_api.dart';

class AnnouncementController extends GetxController {
  static AnnouncementController to = Get.find();
  getNotification(String userID) {
    //for now we just return Firebase data,
    //sometime in future we might manipulate before return
    return AnnouncementApi().getNotification(userID);
  }

  setNotification() {}
}
