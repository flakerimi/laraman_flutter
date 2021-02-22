import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/transactions/controllers/transaction_controller.dart';
import 'package:laraman/modules/transactions/models/transaction.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Helper {
  scan() async {
    String results = await scanner.scan();
    if (results != null) {
      return results;
    } else {
      print('Scan: Empty');
      return results = 'Empty';
    }
  }

  stringToUri(String qrcode) {
    return Uri.parse(qrcode);
  }

  showPaymentBottomSheet(context, Merchant merchant,
      LaramanTransaction transaction, double balance) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.green, spreadRadius: 3),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: merchant.logo,
                      height: 50,
                      width: 50,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),

                    /* CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        merchant.logo,
                      ),
                    ), */
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
                    )
                  ],
                ),
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
                VerticalDivider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VerticalDivider(),
                    ElevatedButton(
                      onPressed: () {
                        makePayment(transaction, balance);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 10),
                        primary: Colors.greenAccent,
                      ),
                      child: Text(
                        "Confirm",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  makePayment(LaramanTransaction payment, double balance) async {
    await TransactionController().addTransaction(payment, balance);
    Get.back();
    Get.defaultDialog(
        title: "Thank you",
        content: Column(
          children: [
            Image.asset('assets/images/check.png'),
            Text('Your payment has been processed or something')
          ],
        ));
    Timer.periodic(Duration(seconds: 3), (_) {
      Get.back();
    });
  }
}
