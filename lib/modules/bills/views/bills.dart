import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/bills/controllers/bill_controller.dart';
import 'package:laraman/modules/bills/models/user_payment.dart';
import 'package:laraman/modules/bills/views/bill_detail.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/partials/header.dart';

class BillIndex extends StatelessWidget {
  BillIndex({this.merchant, this.balance, this.transaction});
  final BillController billController = BillController.to;
  final double balance;
  final Payment transaction;
  final Merchant merchant;

// final merchant = data[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Faturat e mia',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: FutureBuilder<List<UserPayment>>(
                  future: billController.getBills(),
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
                                () => BillDetailIndex(),
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
