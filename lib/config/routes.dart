import 'package:get/get.dart';
import 'package:laraman/modules/account/views/index.dart';
import 'package:laraman/modules/friendship/views/requests.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/payment/views/request/payment_request.dart';
import 'package:laraman/modules/settings/views/index.dart';
import 'package:laraman/splash.dart';

import 'package:laraman/modules/settings/views/edit_profile.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/home', page: () => HomeIndex()),
    GetPage(name: '/settings', page: () => SettingsIndex()),
    GetPage(name: '/edit-profile', page: () => EditProfile()),
    GetPage(name: '/payment_requests', page: () => PaymentRequests()),
    GetPage(name: '/friendsrequests', page: () => FriendRequests()),
  ];
}
