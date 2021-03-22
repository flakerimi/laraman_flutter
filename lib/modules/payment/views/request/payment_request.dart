import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/payment/controllers/payment_controller.dart';
import 'package:laraman/modules/payment/models/user_payment.dart';
import 'package:laraman/partials/header.dart';

import '../user_payment_detail.dart';

class PaymentRequests extends StatelessWidget {
  final AccountController accountController = AccountController.to;
  final PaymentController paymentController = PaymentController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        alignment: Alignment.center,
        child: FutureBuilder<List<UserPayment>>(
          future: paymentController
              .getPaymentRequests(accountController.firebaseUser.value.uid),
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
    );
  }
}
