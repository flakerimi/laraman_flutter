import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/announcement/controller/announcement_controller.dart';
import 'package:laraman/modules/announcement/view/index.dart';
import 'package:laraman/modules/home/views/index.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final AccountController accountController = AccountController.to;
  final AnnouncementController announcementController =
      AnnouncementController.to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: AppBar(
        automaticallyImplyLeading: true,
        title: GestureDetector(
          onTap: () => Get.to(() => HomeIndex(), transition: Transition.fadeIn),
          child: Text(
            'LARAMAN',
            style: GoogleFonts.rubik(
              color: Colors.indigo,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        /*  leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu_sharp),
              color: Colors.indigo,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ), */
        actions: <Widget>[
          StreamBuilder<QuerySnapshot>(
            // <2> Pass `Stream<QuerySnapshot>` to stream
            stream: announcementController
                .getNotificationCount(accountController.firebaseUser.value.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                final documents = snapshot.data.docs.length;

                if (documents != 0) {
                  return IconButton(
                    icon: Badge(
                      badgeColor: Colors.indigo,
                      badgeContent: Text(
                        documents.toString(),
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      child: Icon(Icons.notifications),
                    ),
                    color: Colors.indigo,
                    onPressed: () => Get.to(() => AnnouncementView()),
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.notifications),
                    color: Colors.indigo,
                    onPressed: () => Get.to(() => AnnouncementView()),
                  );
                }
              } else if (snapshot.hasError) {
                return Text('It\'s Error!');
              }
              return Text('');
            },
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.settings_outlined),
                color: Colors.indigo,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
