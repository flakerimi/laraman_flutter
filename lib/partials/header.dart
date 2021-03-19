import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laraman/modules/announcement/view/index.dart';
import 'package:laraman/modules/home/views/index.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AppBar(
        automaticallyImplyLeading: true,
        title: GestureDetector(
          onTap: () => Get.to(() => HomeIndex(), transition: Transition.fadeIn),
          child: Text(
            'LARAMAN',
            style: GoogleFonts.rubik(
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
          IconButton(
            icon: Badge(
              badgeColor: Colors.indigo,
              badgeContent: Text(
                '3',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              child: Icon(Icons.notifications),
            ),
            color: Colors.indigo,
            onPressed: () => Get.to(() => AnnouncementView()),
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.person),
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
  Size get preferredSize => const Size.fromHeight(100);
}
