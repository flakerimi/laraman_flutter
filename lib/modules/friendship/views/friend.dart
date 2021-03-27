import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/friendship/views/send/request_money.dart';
import 'package:laraman/modules/friendship/views/send/send_money.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class FriendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Friend args = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.indigo),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrettyQr(
              data: "laraman://" + args.uid,
              size: 100,
              image: AssetImage('assets/images/l.png'),
              typeNumber: 3,
              errorCorrectLevel: QrErrorCorrectLevel.M,
            ),
            Text(args.firstName + ' ' + args.lastName),
            Text(args.phoneNumber + ' / ' + args.email),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Get.to(() => SendMoney(),
                      arguments: args,
                      transition: Transition.rightToLeftWithFade),
                  child: Text('Send'),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => RequestMoney(),
                      arguments: args,
                      transition: Transition.rightToLeftWithFade),
                  child: Text('Request'),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
