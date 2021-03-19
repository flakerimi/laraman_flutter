import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/partials/header.dart';

class PaymentRequests extends StatelessWidget {
  final TextEditingController text = TextEditingController();
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Payment payment = args['payment'];
    Friend friend = args['friend'];

    return Scaffold(
      appBar: Header(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('Send payment of : ' +
                (payment.amount).toPrecision(2).toString()),
            Text('To : ' + (friend.firstName).toString()),
            ElevatedButton(
                onPressed: () => Get.to(() => HomeIndex()),
                child: Text('Send Payment Request'))
          ],
        ),
      ),
    );
  }
}
