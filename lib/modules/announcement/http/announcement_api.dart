import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnnouncementApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getNotification(userID) {
    return _db
        .collection("notifications")
        .where("userId", isEqualTo: userID)
        .snapshots();
    //.map((snapshot) => Announcement.fromDocumentSnapshot(snapshot.docs));
  }

  setNotification(userID) {}
}
