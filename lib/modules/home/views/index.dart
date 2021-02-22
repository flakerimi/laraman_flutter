import 'package:laraman/helpers/global.dart';
import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/merchant/http/merchant_service.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:laraman/modules/transactions/controllers/transaction_controller.dart';
import 'package:laraman/modules/transactions/models/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/partials/header.dart';

class HomeView extends StatelessWidget {
  scanButton() async {
    AccountController accountController = Get.find<AccountController>();

    var scanResults = await Helper().scan();
    //print(scanResults);
    var scanData = await Helper().stringToUri(scanResults);
    //print(scanData.queryParameters);

    Merchant merchant = await MerchantController()
        .getMerchant(scanData.queryParameters['merchantId']);
    print(merchant.logo);
    Transaction transaction = Transaction(
      scanData.queryParameters['merchantId'],
      scanData.queryParameters['branchId'],
      scanData.queryParameters['posId'],
      double.parse(scanData.queryParameters['amount']),
      accountController.account.value.uid,
      scanData.queryParameters['description'],
    );
    Helper().showPaymentBottomSheet(merchant, transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            VerticalDivider(),
            VerticalDivider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                VerticalDivider(),
                GetX<AccountController>(builder: (_) {
                  return Column(
                    children: [
                      Text(
                        'Welcome ${_.account?.value?.firstName} ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _.account?.value?.address ?? 'fkaj',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _.account?.value?.city ?? 'fkaj',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _.account?.value?.country ?? 'fkaj',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }),
                VerticalDivider(),
                Text(FirebaseAuth.instance.currentUser.phoneNumber,
                    style: TextStyle(fontSize: 16)),
                VerticalDivider(),
                Text(FirebaseAuth.instance.currentUser.uid,
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            VerticalDivider(),
            ElevatedButton(
              onPressed: () {
                print('scan');
                scanButton();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              ),
              child: Text(
                "SCAN",
                style: TextStyle(fontSize: 30),
              ),
            ),
            VerticalDivider(),
          ],
        ),
      ),
    );
  }
}
