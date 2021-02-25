import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laraman/helpers/global.dart';
import 'package:laraman/modules/ledger/models/ledger.dart';
import 'package:laraman/modules/merchant/controller/merchant_controller.dart';
import 'package:laraman/modules/merchant/model/merchant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class HomeView extends StatelessWidget {
  final AccountController accountController = AccountController.to;

  scanButton(context) async {
    var scanResults = await Helper().scan();
    //print(scanResults);
    var scanData = await Helper().stringToUri(scanResults);
    //print(scanData.queryParameters);

    Merchant merchant = await MerchantController()
        .getMerchant(scanData.queryParameters['merchantId']);

    //$newprice = $price * ((100-$amount) / 100);
    double laramanAmount =
        double.parse(scanData.queryParameters['amount']) * merchant.feeDouble;

    double netAmount = double.parse(scanData.queryParameters['amount']) -
        (double.parse(scanData.queryParameters['amount']) * merchant.feeDouble);
    String fullName = accountController.account.value.firstName +
        ' ' +
        accountController.account.value.lastName;
    var transaction = Ledger(
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
      backgroundColor: Colors.white,
      appBar: Header(),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetX<AccountController>(builder: (_) {
              return _.account.value == null
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(40),
                            ),
                            color: Colors.indigo,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(40),
                                  ),
                                ),
                                child: SvgPicture.string(
                                  _.account?.value?.qrSvg,
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.none,
                                ),
                              ),
                              VerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_.account.value.firstName} ${_.account.value.lastName}',
                                    style: GoogleFonts.rubik(
                                        fontSize: 23, color: Colors.white),
                                  ),
                                  Divider(
                                    height: 5,
                                  ),
                                  Text(
                                    '${_.account.value.phoneNumber}  ',
                                    style: GoogleFonts.rubik(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                  Divider(
                                    height: 20,
                                  ),
                                  Text(
                                    'CURRENT BALANCE',
                                    style: GoogleFonts.rubik(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_.account.value.balance.toPrecision(2)}  ',
                                        style: GoogleFonts.rubik(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                      Text(
                                        '€ ',
                                        style: GoogleFonts.rubik(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
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
                      ],
                    );
            })),
      ),
    );
  }
}
