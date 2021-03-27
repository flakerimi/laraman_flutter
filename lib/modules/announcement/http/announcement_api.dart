import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laraman/modules/announcement/model/announcement.dart';

class AnnouncementApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getNotification(userID) {
    return _db
        .collection("notifications")
        .where("userId", isEqualTo: userID)
        .where("isArchive", isEqualTo: false)
        .snapshots();
    //.map((snapshot) => Announcement.fromDocumentSnapshot(snapshot.docs));
  }

  setNotification(Announcement announcement) {
    return _db.collection("notifications").add(announcement.toJson());
  }

  Stream<QuerySnapshot> getNotificationCount(String userID) {
    return _db
        .collection("notifications")
        .where("userId", isEqualTo: userID)
        .where("isRead", isEqualTo: false)
        .where("isArchive", isEqualTo: false)
        .snapshots();
  }

  markAsRead(String docId) {
    return _db.collection("notifications").doc(docId).update({'isRead': true});
  }

  archive(String docId) {
    markAsRead(docId);
    return _db
        .collection("notifications")
        .doc(docId)
        .update({'isArchive': true});
  }
}
