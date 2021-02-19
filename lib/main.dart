import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'modules/auth/views/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Laraman());
}

class Laraman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laraman',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.indigo,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.indigo,
        ),
      ),
      home: LoginView(),
    );
  }
}
