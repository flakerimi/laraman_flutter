import 'package:get/get.dart';
import 'package:laraman/modules/account/models/account.dart';
import 'package:laraman/modules/friendship/http/friend_service.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();
  RxMap<dynamic, dynamic> isChecked = {}.obs;
  RxMap<dynamic, dynamic> checkedData = {}.obs;
  void setIsChecked(index, value) {
    (value == true) ? isChecked[index] = value : isChecked.remove(index);
  }

  void setCheckedData(index, value) {
    print(index);
    print(value.firstName);
    (index != null) ? checkedData[index] = value : checkedData.remove(index);
  }

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
}
