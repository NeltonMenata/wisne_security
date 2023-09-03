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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/logo/logo.png"),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Wisne Security"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Melhor Plataforma de Segurança no Seu Bolso!!"),
          )
        ],
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
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Routes.WELCOME);
    });
  }
}
