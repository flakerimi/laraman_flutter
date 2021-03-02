import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/payment/controllers/payment_controller.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/partials/header.dart';

class PaymentView extends StatelessWidget {
  PaymentView({this.merchant, this.balance, this.transaction});

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
      floatingActionButton: FloatingActionButton(
        child: myPopMenu(),
        onPressed: () {
          return myPopMenu();
        },
      ),
      appBar: Header(),
      body: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: merchant.logo,
                height: 50,
                width: 50,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
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
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Per pagese:'),
              Text(
                '${transaction.amount} €',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                '${transaction.description}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          ),
          Spacer(),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              makePayment(transaction, balance);
            },
            style: ElevatedButton.styleFrom(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              primary: Colors.limeAccent.shade700,
            ),
            child: Text(
              "Paguaj",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

Widget myPopMenu() {
  return PopupMenuButton(
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.print),
                    ),
                    Text('Ndaje pagesen me shoke')
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.share),
                    ),
                    Text('Paguaj me keste')
                  ],
                )),
            PopupMenuItem(
                value: 3,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.add_circle),
                    ),
                    Text('Dergoja pagesen shokut')
                  ],
                )),
          ]);
}
