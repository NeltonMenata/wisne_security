import 'package:flutter/material.dart';
import 'package:wisne_security/core/firebase_core/firebase_init.dart';

import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseCore.init();
  runApp(const MyApp());
}
