import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/subscription/views/add.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class ListAvaiableMerchants extends StatelessWidget {
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
                Text(
                  'Abonohu',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Spacer(),
              ],
            ),
            FutureBuilder<List<Merchant>>(
              future: MerchantController().getSubscriptionMerchant(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: snapshot.data
                        .map(
                          (doc) => ListTile(
                              leading: CachedNetworkImage(
                                width: 50,
                                height: 50,
                                imageUrl: doc.logo,
                              ),
                              title: Text(doc.businessName?.toString()),
                              subtitle: Text(doc.uniqueIdentificationNumber),
                              trailing: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 30,
                              ),
                              onTap: () {
                                Get.to(() => SubscriptionAddView(),
                                    arguments: doc);
                              }),
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
}
