import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/routes.dart';
import 'modules/account/controllers/account_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AccountController>(AccountController());
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
        iconTheme: IconThemeData(
          color: Colors.indigo,
          size: 11.2,
        ),
        primarySwatch: Colors.indigo,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.indigo,
          ),
          headline1: TextStyle(
            fontSize: 20,
            color: Colors.indigo,
          ),
        ),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme.copyWith(
                headline4: TextStyle(
                  fontSize: 30,
                  color: Colors.indigo,
                ),
              ),
        ),
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(),
            color: Colors.indigo,
            iconTheme: IconThemeData(
              color: Colors.indigo,
              size: 11.2,
            )),
      ),
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
