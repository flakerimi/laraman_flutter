import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laraman/helpers/global.dart';
import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/modules/payment/views/payment.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

class HomeIndex extends StatelessWidget {
  final AccountController accountController = AccountController.to;
  final MerchantController merchantController = MerchantController.to;

  scanButton(context) async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      var scanResults = await Helper().scan();
      //print(scanResults);
      var scanData = await Helper().stringToUri(scanResults);
      print(scanData.queryParameters);
      double amount = double.parse(scanData.queryParameters['amount']);
      Merchant merchant = await merchantController
          .getMerchant(scanData.queryParameters['merchantId']);

      //$newprice = $price * ((100-$amount) / 100);
      double laramanAmount = amount * merchant.feeDouble;

      double netAmount = amount - (amount * merchant.feeDouble);
      String fullName = accountController.account.value.firstName +
          ' ' +
          accountController.account.value.lastName;
      var transaction = Payment(
        scanData.queryParameters['merchantId'],
        merchant.businessName,
        merchant.logo,
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
        amount,
        merchant.feeDouble,
        merchant.feeString,
        laramanAmount,
        netAmount,
        'Processed',
        Timestamp.now(),
        Timestamp.now(),
      );

      if (accountController.account.value.balance >= amount) {
        Get.to(
            () => PaymentIndex(
                  merchant: merchant,
                  transaction: transaction,
                  balance: accountController.account.value.balance,
                ),
            arguments: [
              context,
            ]);
      } else {
        Get.defaultDialog(
            title: 'Not enough funds!',
            content: Text('Add some funds on balance.'));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Camera Permission'),
                content: Text(
                    'This app needs camera access to take pictures for upload user profile photo'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: Text('Settings'),
                    onPressed: () => openAppSettings(),
                  ),
                ],
              ));
    }
    // Get.to(
    //   () => PaymentIndex(),
    //   arguments: [merchant, transaction],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: Center(
        child: Obx(
          () => accountController.account.value == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 400,
                      height: 300.0,
                      child: CarouselSlider(
                        items: [
                          BalanceCard(
                            userData: accountController,
                          ),
                          ProfileCard(
                            userData: accountController,
                          ),
                          TopMerchantsCard(
                            userData: accountController,
                            merchantData: merchantController,
                          ),
                        ],
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            height: 300,
                            onPageChanged: (index, reason) {}),
                      ),
                    ),
                    Divider(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('scan');
                        scanButton(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(40),
                      ),
                      child: Text(
                        "SCAN",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Divider()
                  ],
                ),
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final AccountController userData;
  const BalanceCard({
    Key key,
    this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.indigo,
        child: Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CURRENT BALANCE',
                style: GoogleFonts.rubik(fontSize: 13, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userData.account.value.balance.toPrecision(2)}  ',
                    style: GoogleFonts.rubik(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    '€ ',
                    style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final AccountController userData;
  const ProfileCard({
    Key key,
    this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PrettyQr(
            image: AssetImage('assets/images/l.png'),
            typeNumber: 3,
            size: 300,
            elementColor: Colors.indigo,
            data: 'laraman://' + userData.account?.value?.uid,
            errorCorrectLevel: QrErrorCorrectLevel.M,
            roundEdges: true));
  }
}

class TopMerchantsCard extends StatelessWidget {
  final AccountController userData;
  final MerchantController merchantData;
  final newList = [].obs;

  TopMerchantsCard({
    Key key,
    this.userData,
    this.merchantData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set da = {};
    var top = merchantData.getTopThreeMerchants(userData.account?.value?.uid);
    top.then((value) => {
          value.map((e) {
            da.add(e.merchantId);
          })
        });
    print(da);
    return Container(
      child: Text(da.toString()),
    );
  }
}
