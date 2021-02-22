import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:laraman/modules/transactions/views/payment.dart';
import 'package:laraman/partials/header.dart';

class HomeView extends StatelessWidget {
  scanButton(context) async {
    AccountController accountController = Get.find<AccountController>();

    var scanResults = await Helper().scan();
    //print(scanResults);
    var scanData = await Helper().stringToUri(scanResults);
    //print(scanData.queryParameters);

    Merchant merchant = await MerchantController()
        .getMerchant(scanData.queryParameters['merchantId']);

    //$newprice = $price * ((100-$amount) / 100);
    double laramanAmount =
        double.parse(scanData.queryParameters['amount']) * merchant.feeDouble;
    print(laramanAmount);
    double netAmount = double.parse(scanData.queryParameters['amount']) -
        (double.parse(scanData.queryParameters['amount']) * merchant.feeDouble);
    String fullName = accountController.account.value.firstName +
        ' ' +
        accountController.account.value.lastName;
    var transaction = LaramanTransaction(
      scanData.queryParameters['merchantId'],
      merchant.businessName,
      int.parse(merchant.uniqueIdentificationNumber),
      merchant.address,
      merchant.city,
      merchant.country,
      merchant.phoneNumber,
      merchant.email,
      scanData.queryParameters['branchId'],
      scanData.queryParameters['posId'],
      accountController.account.value.uid,
      fullName,
      accountController.account.value.phoneNumber,
      accountController.account.value.email ?? ' ',
      scanData.queryParameters['description'],
      double.parse(scanData.queryParameters['amount']),
      merchant.feeDouble,
      merchant.feeString,
      laramanAmount,
      netAmount,
      'Processed',
      DateTime.now(),
      DateTime.now(),
    );
    //TODO fix this
    print(accountController?.account?.value?.uid);
    print(transaction.customerId);
    if (accountController.account.value.balance >=
        double.parse(scanData.queryParameters['amount'])) {
      await Helper().showPaymentBottomSheet(context, merchant, transaction,
          accountController.account.value.balance);
    } else {
      Get.defaultDialog(
          title: 'Not enough funds!',
          content: Text('Add some funds on balance.'));
    }
    // Get.to(
    //   () => PaymentView(),
    //   arguments: [merchant, transaction],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              VerticalDivider(),
              GetX<AccountController>(builder: (_) {
                return Column(
                  children: [
                    SvgPicture.string(_.account?.value?.qrSvg ?? "s"),
                    Text(
                      'Welcome ${_.account?.value?.firstName} ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      _.account?.value?.balance.toString() ?? '0',
                      style: TextStyle(fontSize: 56),
                    ),
                  ],
                );
              }),
              VerticalDivider(),
              ElevatedButton(
                onPressed: () {
                  print('scan');
                  scanButton(context);
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
      ),
    );
  }
}
