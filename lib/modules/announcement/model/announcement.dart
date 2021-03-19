import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String userId;
  final bool isArchive;
  final bool isRead;
  final String link;
  final String title;
  final Timestamp createdAt;
  final String message;

  Announcement({
    this.userId,
    this.isArchive,
    this.isRead,
    this.link,
    this.title,
    this.createdAt,
    this.message,
  });
  factory Announcement.fromMap(Map data) {
    return Announcement(
      userId: data['userId'],
      isArchive: data['isArchive'],
      isRead: data['isRead'],
      link: data['link'],
      title: data['title'],
      createdAt: data['createdAt'],
      message: data['message'],
    );
  }
  factory Announcement.fromDocumentSnapshot(DocumentSnapshot data) {
    return Announcement(
      userId: data['userId'],
      isArchive: data['isArchive'],
      isRead: data['isRead'],
      link: data['link'],
      title: data['title'],
      createdAt: data['createdAt'],
      message: data['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "isArchive": isArchive,
        "isRead": isRead,
        "link": link,
        "title": title,
        "createdAt": createdAt,
        "message": message,
      };
}
