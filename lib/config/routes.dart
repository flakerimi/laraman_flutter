import 'package:get/get.dart';
import 'package:laraman/modules/Auth/views/index.dart';
import 'package:laraman/modules/Home/views/index.dart';
import 'package:laraman/splash.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: '/signin', page: () => LoginView()),
    GetPage(name: '/home', page: () => HomeView()),
    /*  GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),*/
  ];
}
