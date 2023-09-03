import 'package:flutter/material.dart';
import 'package:wisne_security/core/firebase_core/firebase_init.dart';
import 'package:wisne_security/layers/presenter/ui/splash/splash_init_page.dart';
import 'my_app/my_app.dart';

void main() async {
  runApp(const SplashInitPage());
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseCore.init();
  runApp(const MyApp());
}
