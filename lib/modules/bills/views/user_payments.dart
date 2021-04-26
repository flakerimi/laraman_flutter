import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/payment/controllers/payment_controller.dart';
import 'package:laraman/modules/payment/models/user_payment.dart';
import 'package:laraman/modules/payment/views/user_payment_detail.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class UserPaymentsIndex extends StatelessWidget {
  Future<List<UserPayment>> _loadTransactions() async {
    return await PaymentController().getUserTransactions();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Pagesat e mia',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: FutureBuilder<List<UserPayment>>(
                  future: _loadTransactions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data;
                            return ListTile(
                              leading: Hero(
                                tag: "logo" + index.toString(),
                                child: Image.network(data[index].merchantLogo),
                              ),
                              title: Text(
                                '${data[index].merchantName}',
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text('${data[index].description}'),
                              trailing: Text(
                                "${data[index].fromAmount.toString()}€",
                                style: TextStyle(fontSize: 30),
                              ),
                              onTap: () => Get.to(
                                () => UserPaymentDetailIndex(),
                                arguments: {
                                  "index": index,
                                  "data": data[index].toJson()
                                },
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
      ),
    );
  }
}
