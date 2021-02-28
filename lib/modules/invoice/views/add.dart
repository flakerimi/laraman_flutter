import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/merchant/model/merchant_packages.dart';
import 'package:laraman/modules/subscription/views/templates/package_listtile.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class SubscriptionAddView extends StatelessWidget {
  final Merchant merchant = Get.arguments;

  Future<List<Merchant>> _refreshData() async {
    return await MerchantController().getSubscriptionMerchant();
    //_data.clear();
    //_data.addAll(SubscriptionService().getSubscriptionRequests());
  }

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
                Column(
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
                      merchant.businessName.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                Spacer(),
                Image.network(
                  merchant.logo,
                  width: 100,
                  height: 100,
                )
              ],
            ),
            FutureBuilder<List<MerchantPackages>>(
              future: MerchantController().getMerchantPackages(merchant.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    color: Colors.green,
                    onRefresh: _refreshData,
                    child: ListView(
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
                              durationTime:
                                  doc.durationTime.toDate().toString(),
                            ),
                          )
                          .toList(),
                    ),
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
