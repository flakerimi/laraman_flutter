import 'package:get/get.dart';
import 'package:laraman/modules/transactions/views/payment.dart';
import 'package:laraman/splash.dart';
import 'package:laraman/modules/account/views/index.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/settings/views/index.dart';
import 'package:laraman/modules/settings/views/edit_profile.dart';

class AppRoutes {
  //Routes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/settings', page: () => SettingsView()),
    GetPage(name: '/edit-profile', page: () => EditProfile()),
    GetPage(name: '/payment', page: () => PaymentView()),
  ];
}
