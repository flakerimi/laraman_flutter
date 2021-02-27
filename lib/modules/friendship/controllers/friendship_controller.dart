import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/http/friend_service.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();
  Rx<List<Friend>> friends = Rx<List<Friend>>();

  final status = 'accepted';
  RxBool isLogged = false.obs;
  Rx<User> firebaseUser = Rx<User>();
  Rx<Friend> friend = Rx<Friend>();

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
