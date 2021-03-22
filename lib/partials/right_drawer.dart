import 'package:flutter/material.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';

class RightDrawer extends StatelessWidget {
  final AccountController accountController = AccountController.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          children: [
            Text(
              "Settings",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              accountController.account.value.uid,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () => accountController.signOut(),
                child: Text('SIgn OUT'))
          ],
        ),
      ),
    );
  }
}
