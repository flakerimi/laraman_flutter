import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/announcement/controller/announcement_controller.dart';
import 'package:laraman/partials/header.dart';

class AnnouncementView extends StatelessWidget {
  final AccountController accountController = AccountController.to;
  final AnnouncementController announcementController =
      AnnouncementController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: StreamBuilder<QuerySnapshot>(
          // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: announcementController
              .getNotification(accountController.firebaseUser.value.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // <3> Retrieve `List<DocumentSnapshot>` from snapshot
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return ListView(
                  children: documents
                      .map((doc) => Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.request_page,
                                size: 32,
                                color: Colors.amber,
                              ),
                              title: Text(doc['title']),
                              subtitle: Text(doc['message']),
                              trailing: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Colors.green,
                                size: 32,
                              ),
                              onTap: () => Get.toNamed(doc['link']),
                            ),
                          ))
                      .toList());
            } else if (snapshot.hasError) {
              return Text('It\'s Error!');
            }
            return Text('');
          }),
    );
  }
}
