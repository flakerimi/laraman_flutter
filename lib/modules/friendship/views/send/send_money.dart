import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';

class SendMoney extends StatelessWidget {
  final TextEditingController amount = TextEditingController();
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Friend friend = args;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.indigo),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            Text('To : ' + (friend.firstName).toString()),
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () => Get.to(() =>
                  FriendController().sendMoney(double.parse(amount.text))),
              child: Text('Send Money'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
