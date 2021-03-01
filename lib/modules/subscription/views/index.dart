import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/subscription/controllers/subscription_controller.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';
import 'package:laraman/modules/subscription/views/list_avaiable_merchants.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class SubscriptionView extends StatelessWidget {
  Future<List<Subscription>> _refreshData() async {
    return await SubscriptionController().getMySubscriptions();
    //_data.clear();
    //_data.addAll(SubscriptionService().getSubscriptionRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => ListAvaiableMerchants(),
            transition: Transition.downToUp,
          );
        },
        child: Icon(Icons.add),
      ),
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
                  'Abonimet e mia',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Spacer(),
              ],
            ),
            FutureBuilder<List<Subscription>>(
              future: _refreshData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    color: Colors.green,
                    onRefresh: _refreshData,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      children: snapshot.data.map((doc) {
                        print(doc.toJson());
                        return ListTile(
                          title: Text(doc.subscriptionName ?? 'ee'),
                          subtitle: Text(doc.subscriptionDescription ?? 'eew'),
                          // trailing: Text(doc.subscriptionPrice.toString() ? 'ee'),
                        );
                      }).toList(),
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
