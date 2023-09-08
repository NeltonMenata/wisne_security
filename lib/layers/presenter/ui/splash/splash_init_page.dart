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
      ),
    );
  }
}
