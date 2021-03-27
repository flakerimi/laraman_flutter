import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'modules/announcement/controller/announcement_controller.dart';
import 'modules/account/controllers/account_controller.dart';
import 'modules/merchant/controller/merchant_controller.dart';
import 'modules/payment/controllers/payment_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AccountController>(AccountController());
  Get.put<AnnouncementController>(AnnouncementController());
  Get.put<MerchantController>(MerchantController());
  Get.put<PaymentController>(PaymentController());
  runApp(Laraman());
}

class Laraman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Platform.isAndroid ?? SystemChrome.setEnabledSystemUIOverlays([]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LARAMAN',
      theme: laramanThemeData(context),
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
