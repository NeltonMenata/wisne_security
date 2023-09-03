import 'package:flutter/material.dart';

class SplashInitPage extends StatefulWidget {
  const SplashInitPage({Key? key}) : super(key: key);

  @override
  State<SplashInitPage> createState() => _SplashInitPageState();
}

class _SplashInitPageState extends State<SplashInitPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
