import 'package:flutter/material.dart';
import 'package:wisne_security/layers/presenter/ui/auth/otp_screen.dart';
import 'package:wisne_security/layers/presenter/ui/auth/register_screen.dart';
import 'package:wisne_security/layers/presenter/ui/auth/welcome_page.dart';
import 'package:wisne_security/layers/presenter/ui/edit_user/edit_user_page.dart';
import 'package:wisne_security/layers/presenter/ui/splash/splash_init_page.dart';
import '../ui/home/home_page.dart';
import '../ui/splash/splash_page.dart';

abstract class Routes {
  static const HOME = "/home";
  static const SPLASH_INIT = "/splash_init";
  static const SPLASH = "/splash";
  static const OTP = "";
  static const WELCOME = "/welcome";
  static const REGISTER = "/register";
  static const EDIT_USER = "/edit_user";

  static Map<String, Widget Function(BuildContext context)> routes(
      BuildContext context) {
    return {
      SPLASH_INIT: (context) => const SplashInitPage(),
      SPLASH: (context) => const SplashPage(),
      HOME: (context) => const HomePage(),
      OTP: (context) => const OtpScreen(),
      WELCOME: (context) => const WelcomePage(),
      REGISTER: (context) => const RegisterScreen(),
      EDIT_USER: (context) => const EditUserPage()
    };
  }
}
