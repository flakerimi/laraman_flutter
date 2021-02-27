import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/routes.dart';
import 'modules/account/controllers/account_controller.dart';
import 'modules/ledger/controllers/ledger_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AccountController>(AccountController());
  Get.put<LedgerController>(LedgerController());
  runApp(Laraman());
}

class Laraman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LARAMAN',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.indigo,
          ),
        ),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.indigo,
        ),
      ),
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
