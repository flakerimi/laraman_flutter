import 'package:get/get.dart';
import 'package:laraman/modules/friendship/http/friend_service.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();
  final RxList isChecked = [].obs;

  Future<List<Friend>> getFriends() async {
    return await FriendService().getFriendsList();
  }

  Future<List<Friend>> getFriendRequests() async {
    return await FriendService().getFriendRequests();
  }

  static makeRequest(_phoneController) async {
    var message = await FriendService().sendFriendRequest(_phoneController);
    Get.back();
    print(message);
  }
}
