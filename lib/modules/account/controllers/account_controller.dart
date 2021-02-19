import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/models/account.dart';

class AccountController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // static AuthController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxBool isLogged = false.obs;
  Rx<User> firebaseUser = Rx<User>();
  Rx<Account> account = Rx<Account>();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onReady();
  }

  Future<User> get getUser async => _auth.currentUser;
  Stream<User> get user => _auth.authStateChanges();
  Stream<Account> streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (firebaseUser?.value?.uid != null) {
      return _db
          .collection('users')
          .doc(firebaseUser.value.uid)
          .snapshots()
          .map((snapshot) => Account.fromMap(snapshot.data()));
      //fsUser.then((value) => {print(value.country)});
    }

    return null;
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      account.bindStream(streamFirestoreUser());
    }

    if (_firebaseUser == null) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/home");
    }
  }
}
