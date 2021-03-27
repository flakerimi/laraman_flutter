import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';
import 'package:laraman/partials/header.dart';

class SubscriptionView extends StatelessWidget {
  final Subscription data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    /* this.merchantBusinessName,
    this.merchantBusinessLogo,
    this.merchantUin,
    this.subscriptionName,
    this.subscriptionDescription,
    this.subscriptionDurationString,
    this.subscriptionDurationTime,
    this.subscriptionPrice,
    this.subscriptionCurrency,
    this.status,
    this.dateCreated,
    this.dateUpdated,*/
    return Scaffold(
      appBar: Header(),
      body: Column(
        children: [
          Image.network(
            data.merchantBusinessLogo,
            width: 150,
          ),
          Text(data.merchantBusinessName),
          Text(data.merchantUin),
          Divider(),
          Text(data.subscriptionName),
          Text(data.subscriptionDescription),
          Text(data.subscriptionDurationString),
          Text(data.subscriptionPrice.toString()),
          Spacer(),
          ElevatedButton(onPressed: () {}, child: Text('Ç\'abonohu')),
          Spacer(),
        ],
      ),
    );
  }
}
