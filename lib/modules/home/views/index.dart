import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/transactions/controllers/transaction_controller.dart';
import 'package:laraman/modules/transactions/models/transaction.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/partials/header.dart';

class HomeView extends StatelessWidget {
  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      barcode = 'Empty';
      print('nothing return.');
    } else {
      qrData(barcode);
    }
  }

  AccountController accountController = Get.find<AccountController>();
  TransactionController transactionController =
      Get.put<TransactionController>(TransactionController());
  MerchantController merchantController =
      Get.put<MerchantController>(MerchantController());
  void qrData(String barcode) {
    Uri uri = Uri.parse(
        'laraman://payment?merchant_id=hQKnwAse2yhW4Jn2W1q4&branch_id=8X4iPlWbrICLwxU3cZvq&pos_id=tVK3usZ207EYdJRGFTcH&amount=12.35');
    String type = uri.host;
    var params = uri.queryParameters;
    print(params['merchant_id']);
    print(type);
    Transaction payment = Transaction(
        params['merchant_id'],
        params['branch_id'],
        params['pos_id'],
        params['amount'],
        accountController.account.value.uid);
    var merchantData = merchantController.getMerchant(payment.merchantId);

    // print(merchantData.businessName);
    Get.bottomSheet(Column(
      children: [
        Container(
          color: Colors.indigo,
          child: Text('data'),
        ),
        ElevatedButton(
            onPressed: () {
              transactionController.addTransaction(payment.toJson());
            },
            child: Text('Confirm')),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel')),
      ],
    ));
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
                _scan();
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
