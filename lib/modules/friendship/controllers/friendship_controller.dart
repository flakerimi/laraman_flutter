import 'package:get/get.dart';
import 'package:laraman/modules/friendship/http/friend_service.dart';
import 'package:laraman/modules/friendship/models/friend.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();

  Future<List<Friend>> getFriends() async {
    return await FriendService().getFriendsList();
  }

  Future<List<Friend>> getFriendRequests() async {
    return await FriendService().getFriendRequests();
  }

  static makeRequest(_phoneController) async {
    await FriendService().sendFriendRequest(_phoneController);
    Get.back();
    print(_phoneController.text);
  }

  Future<Friend> sendMoney(double amount) async {
    return await FriendService().sendMoney(amount);
  }

  Future<Friend> requestMoney(double amount) async {
    return await FriendService().requestMoney(amount);
  }
}
