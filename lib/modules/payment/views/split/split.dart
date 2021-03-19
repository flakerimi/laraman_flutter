import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/partials/header.dart';

class Split extends StatelessWidget {
  final TextEditingController text = TextEditingController();
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Payment payment = args['payment'];
    var friends = args['friends'].entries;
    print(friends.length);
    return Scaffold(
      appBar: Header(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('My Participation: ' +
                (payment.amount / (friends.length + 1))
                    .toPrecision(2)
                    .toString()),
            Obx(
              () {
                print('data: ' + args.toString());
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: args['friends'].entries.map<Widget>((friend) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(friend.value.firstName),
                          Spacer(),
                          Expanded(
                            child: TextField(
                              controller: text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText:
                                      (payment.amount / (friends.length + 1))
                                          .toPrecision(2)
                                          .toString()),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            ElevatedButton(
                onPressed: () => Get.to(() => HomeIndex()),
                child: Text('Send Payment Request'))
          ],
        ),
      ),
    );
  }
}
