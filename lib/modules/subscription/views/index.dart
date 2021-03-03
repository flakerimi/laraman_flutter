import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/subscription/controllers/subscription_controller.dart';
import 'package:laraman/modules/subscription/models/subscription.dart';
import 'package:laraman/modules/subscription/views/list_avaiable_merchants.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class SubscriptionIndex extends StatelessWidget {
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
            Divider(),
            Expanded(
              child: FutureBuilder<List<Subscription>>(
                future: _refreshData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data;
                          return ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Hero(
                              tag: "logo" + index.toString(),
                              child: CachedNetworkImage(
                                width: 150,
                                height: 150,
                                imageUrl: data[index].merchantBusinessLogo,
                              ),
                            ),
                            title: Text(
                              data[index].merchantBusinessName,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(data[index].subscriptionDescription),
                            trailing: IconButton(
                              onPressed: () {},
                              color: Colors.green,
                              icon: Icon(Icons.keyboard_arrow_right),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('Its Error! Refresh');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
