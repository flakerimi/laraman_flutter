import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/settings/models/account.dart';

class AccountService {
  getAccount(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return Account.fromDocumentSnapshot(doc);
    } catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
  }

  setAccount(Account account) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        "firstName": account.firstName,
        "lastName": account.lastName,
        "email": account.email,
        "address": account.address,
        "city": account.city,
        "country": account.country,
      });
    } catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
  }
}
