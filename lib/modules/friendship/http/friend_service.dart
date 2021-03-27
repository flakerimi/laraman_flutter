import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';

class FriendService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AccountController accountController = AccountController.to;

  Future<List<Friend>> getFriendsList() async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('friends')
        .where('status', whereIn: ['requested', 'accepted']).get();

    return qShot.docs.map((doc) => Friend.fromMap(doc.data())).toList();
  }

  Future<List<Friend>> getFriendRequests() async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('friends')
        .where('status', isEqualTo: 'requested')
        .get();

    return qShot.docs.map((doc) => Friend.fromMap(doc.data())).toList();
  }

  Future<Friend> getFriendByPhoneNumber(phoneController) async {
    QuerySnapshot qShot = await _db
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneController)
        .get();

    return Friend.fromMap(qShot.docs.first.data()); //((doc) =>  doc.data());
  }

  Future<Friend> getFriendByUid(uid) async {
    return _db
        .collection('users')
        .doc(uid)
        .get()
        .then((snapshot) => Friend.fromMap(snapshot.data()));
  }

  isFriendOf(uid) {
    bool iss = false;
    _db
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('friends')
        .doc(uid)
        .get()
        .then((value) => iss = value.exists);
    return iss;
  }

  sendFriendRequest(phoneController) {
    var fsUser = _db.collection('users');
    //print(phoneController);
    fsUser.where('phoneNumber', isEqualTo: phoneController).get().then((value) {
      // print(value.docs.length);
      if (value.docs.length != 0) {
        var snapshot = value.docs[0];
        var id = snapshot.id;
        var data = snapshot.data();
        var fo = Friend.fromMap(data);
        // print(fo.toJson());
        Friend friend = Friend(
          status: 'requested',
          firstName: fo.firstName,
          lastName: fo.lastName,
          dateCreated: Timestamp.now(),
          dateUpdated: Timestamp.now(),
          phoneNumber: fo.phoneNumber,
          email: fo.email,
          uid: id,
          address: fo.address,
          city: fo.city,
          country: fo.country,
          qr: fo.qr,
          qrSvg: fo.qr,
        );
        print(friend.firstName);
        return friend;
      } else {
        Get.snackbar("User not exist", 'message');
      }
    });
  }

  saveFriendRequest(Friend friend) async {
    print(friend.phoneNumber);
    var fsUser = _db.collection('users');
    /*  await fsUser
        .doc(friend.uid)
        .collection('friends')
        .doc(accountController.account.value.uid)
        .set(accountController.account.value.toJson()); */
    await fsUser
        .doc(auth.currentUser.uid)
        .collection('friends')
        .doc(friend.uid)
        .set(friend.toJson());
    /*   await fsUser
        .doc(friend.uid)
        .collection('friends')
        .doc(accountController.account.value.uid)
        .update({'status': 'requested'}); */
    await fsUser
        .doc(auth.currentUser.uid)
        .collection('friends')
        .doc(friend.uid)
        .update({'status': 'requested'});
    return "success";
  }

  sendMoney(double amount) {
    print(amount);
  }

  requestMoney(double amount) {
    print(amount);
  }

  acceptFriend(String uid) {
    var fsUser = _db.collection('users');

    fsUser
        .doc(auth.currentUser.uid)
        .collection('friends')
        .doc(uid)
        .update({'status': 'accepted'});
    fsUser
        .doc(uid)
        .collection('friends')
        .doc(accountController.account.value.uid)
        .set(accountController.account.value.toJson());

    fsUser
        .doc(uid)
        .collection('friends')
        .doc(auth.currentUser.uid)
        .update({'status': 'accepted'});
    Get.back();
  }

  rejectFriend(String uid) {
    var fsUser = _db.collection('users');

    fsUser
        .doc(auth.currentUser.uid)
        .collection('friends')
        .doc(uid)
        .update({'status': 'declined'});
    Get.back();
  }
}
