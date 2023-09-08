import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

//
class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/logo.png",
              height: 150,
              width: 150,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Wisne Security",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Melhor Plataforma de Segurança no Seu Bolso!!",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      nextPage();
    }
  }

  void nextPage() async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Routes.WELCOME);
    });
  }
}
