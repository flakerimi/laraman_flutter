import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';

import 'modules/home/views/index.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (controller) => controller?.account?.value?.uid == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : HomeView());
  }
}
