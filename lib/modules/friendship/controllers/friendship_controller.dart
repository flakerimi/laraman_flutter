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
    if (friend.uid != null) {
      await FriendService().saveFriendRequest(friend);
      //  print(accountcontroller.account.value.firstName);
      await announcementController.setNotification(
          userId: friend.uid,
          isRead: false,
          isArchive: false,
          link: '/friendsrequests',
          createdAt: Timestamp.now(),
          title: "Friend Request",
          message:
              "${accountcontroller.account.value.firstName} has sent you a friend request");
      Get.back();
    }
  }

  Future<Friend> sendMoney(double amount) async {
    return await FriendService().sendMoney(amount);
  }

  Future<Friend> requestMoney(double amount) async {
    return await FriendService().requestMoney(amount);
  }

  static rejectFriend(String uid) {
    FriendService().rejectFriend(uid);
  }

  static acceptFriend(String uid) {
    FriendService().acceptFriend(uid);
  }
}
