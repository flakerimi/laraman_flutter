import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/merchant/model/merchant_packages.dart';
import 'package:laraman/modules/subscription/http/subscription_service.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';
import 'package:laraman/modules/subscription/views/templates/package_listtile.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class SubscriptionAddView extends StatelessWidget {
  final Merchant merchant = Get.arguments;
  final account = AccountController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abonohu ne'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.indigo),
                      ),
                      Text(
                        merchant?.businessName?.toUpperCase() ??
                            'Merchant not found',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Image.network(
                  merchant.logo,
                  width: 50,
                  height: 50,
                )
              ],
            ),
            FutureBuilder<List<MerchantPackages>>(
              future: MerchantController().getMerchantPackages(merchant.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: snapshot.data
                        .map(
                          (doc) => PackageList(
                            name: doc.name,
                            description: doc.description,
                            price: doc.price.toString(),
                            durationString: doc.durationString,
                            durationTime: doc.durationTime.toDate().toString(),
                            pressed: () {
                              // print(doc.toJson());
                              subscribe(doc);
                            },
                          ),
                        )
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Its Error! Refresh');
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void subscribe(doc) {
    Subscription data = Subscription(
      customerUid: account.account.value.uid,
      customerFirstName: account.account.value.firstName,
      customerLastName: account.account.value.lastName,
      customerPhoneNumber: account.account.value.phoneNumber,
      merchantUid: merchant.uid,
      merchantBusinessName: merchant.businessName,
      merchantBusinessLogo: merchant.logo,
      merchantUin: merchant.uniqueIdentificationNumber,
      subscriptionName: doc.name,
      subscriptionDescription: doc.description,
      subscriptionDurationString: doc.durationString,
      subscriptionPrice: doc.price,
      subscriptionCurrency: doc.currency,
      status: 'subscribed',
      dateCreated: Timestamp.now(),
      dateUpdated: Timestamp.now(),
    );

    return SubscriptionService().sendSubscriptionRequest(data);
  }
}
