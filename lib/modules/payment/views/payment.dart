import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/payment/controllers/payment_controller.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/modules/payment/views/send/select_friend.dart';
import 'package:laraman/modules/payment/views/split/select_friends.dart';
import 'package:laraman/partials/header.dart';

import 'installment/select_installement.dart';

class PaymentIndex extends StatelessWidget {
  PaymentIndex({this.merchant, this.balance, this.transaction});

  final double balance;
  final Payment transaction;
  final Merchant merchant;

// final merchant = data[0];
  @override
  Widget build(BuildContext context) {
    makePayment(Payment payment, double balance) async {
      Get.back();
      await PaymentController().addTransaction(payment, balance);
    }

    return Scaffold(
      appBar: Header(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: merchant.logo,
                  height: 50,
                  width: 50,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        merchant.businessName,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(merchant.businessNumber),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pagesë',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Per pagese:'),
                    Text(
                      '${transaction.amount} €',
                      style: TextStyle(fontSize: 50),
                    ),
                    Text(
                      '${transaction.description}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  makePayment(transaction, balance);
                },
                child: Text(
                  "Paguaj",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextButton(
                child: Icon(Icons.more_vert),
                onPressed: () {
                  return bottomSheet(transaction);
                },
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

bottomSheet(Payment payment) async {
  return await Get.bottomSheet(Container(
    width: double.infinity,
    padding: EdgeInsets.only(top: 20),
    margin: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Wrap(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.music_note),
          title: Text('Ndaje pagesen me shoke'),
          onTap: () => Get.to(() => SelectFriends(), arguments: payment),
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Dergoja pagesen shokut'),
          onTap: () => Get.to(() => SelectFriend(), arguments: payment),
          tileColor: Colors.white38,
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Paguaj me keste'),
          onTap: () => Get.to(() => SelectInstallment(), arguments: payment),
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Shake'),
          onTap: () => {},
        ),
      ],
    ),
  ));
}
