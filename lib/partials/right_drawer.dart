import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';

class RightDrawer extends StatelessWidget {
  final AccountController accountController = AccountController.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Settings",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () => accountController.signOut(),
                  child: Text('Sign out'))
            ],
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  leading: Icon(
                    Icons.qr_code_outlined,
                    size: 20,
                  ),
                  title: Text(
                    'Your Profile',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                ExpansionTile(
                  leading: Icon(
                    Icons.account_box_outlined,
                    size: 20,
                  ),
                  title: Text(
                    'Account Settings',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                ExpansionTile(
                  leading: Icon(
                    Icons.app_settings_alt_outlined,
                    size: 20,
                  ),
                  title: Text(
                    'App Setting',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
