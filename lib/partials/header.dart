import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/settings/views/index.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          color: Colors.indigo,
          onPressed: () {
            // Get.to(SettingsUI());
          },
        ),
        title: Text('LARAMAN'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {
              Get.to(() => SettingsView());
            },
            color: Colors.indigo,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
