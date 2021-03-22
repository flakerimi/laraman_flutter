import 'package:get/get.dart';
import 'package:laraman/modules/announcement/http/announcement_api.dart';
import 'package:laraman/modules/announcement/model/announcement.dart';

class AnnouncementController extends GetxController {
  static AnnouncementController to = Get.find();
  getNotification(String userID) {
    //for now we just return Firebase data,
    //sometime in future we might manipulate before return
    return AnnouncementApi().getNotification(userID);
  }

  getNotificationCount(String userID) {
    //for now we just return Firebase data,
    //sometime in future we might manipulate before return
    return AnnouncementApi().getNotificationCount(userID);
  }

  setNotification(
      {userId, isArchive, isRead, link, title, createdAt, message}) {
    var announcement = Announcement(
        userId: userId,
        isArchive: isArchive,
        isRead: isRead,
        title: title,
        createdAt: createdAt,
        message: message);
    AnnouncementApi().setNotification(announcement);
  }
}
