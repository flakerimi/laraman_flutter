import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/announcement/controller/announcement_controller.dart';

class AnnouncementView extends StatelessWidget {
  final AccountController accountController = AccountController.to;
  final AnnouncementController announcementController =
      AnnouncementController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          PopupMenuButton(
            initialValue: 2,
            padding: EdgeInsets.all(50),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.more_vert,
                  size: 30,
                )),
            itemBuilder: (context) {
              return List.generate(5, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text('button no $index'),
                );
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: announcementController
              .getNotification(accountController.firebaseUser.value.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // <3> Retrieve `List<DocumentSnapshot>` from snapshot
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: documents
                          .map(
                            (doc) => Dismissible(
                              key: Key(doc.id),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  announcementController.archive(doc.id);
                                  documents.remove(doc.id);
                                }
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: doc['isRead']
                                        ? Colors.grey.shade100
                                        : Colors.grey.shade300,
                                    leading: Icon(
                                      Icons.request_page,
                                      size: 32,
                                      color: Colors.amber,
                                    ),
                                    title: Text(doc['title']),
                                    subtitle: Text(doc['message']),
                                    trailing: IconButton(
                                      icon: Icon(Icons.archive),
                                      onPressed: () {},
                                    ),
                                    onTap: () {
                                      Get.toNamed(doc['link']);
                                      announcementController.markAsRead(doc.id);
                                    },
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('It\'s Error!');
            }
            return Text('');
          }),
    );
  }
}
