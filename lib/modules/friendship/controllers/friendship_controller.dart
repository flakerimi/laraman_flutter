import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/announcement/controller/announcement_controller.dart';
import 'package:laraman/modules/friendship/http/friend_service.dart';
import 'package:laraman/modules/friendship/models/friend.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();
  AnnouncementController announcementController = AnnouncementController.to;
  AccountController accountcontroller = AccountController.to;
  Future<List<Friend>> getFriends() async {
    return await FriendService().getFriendsList();
  }

  Future<List<Friend>> getFriendRequests() async {
    return await FriendService().getFriendRequests();
  }

  makeRequest(_phoneController) async {
    Friend friend =
        await FriendService().getFriendByPhoneNumber(_phoneController);
    print('fr' + friend.firstName);
    if (friend.uid != null) {
      //  FriendService().saveFriendRequest(friend);
      //  print(accountcontroller.account.value.firstName);
      announcementController.setNotification(
          userId: friend.uid,
          isRead: false,
          isArchive: false,
          link: 'friend_requests',
          createdAt: Timestamp.now(),
          title: "Friend Request",
          message:
              "${accountcontroller.account.value.firstName} has sent you a friend request");
    }
  }

  Future<Friend> sendMoney(double amount) async {
    return await FriendService().sendMoney(amount);
  }

  Future<Friend> requestMoney(double amount) async {
    return await FriendService().requestMoney(amount);
  }
}
