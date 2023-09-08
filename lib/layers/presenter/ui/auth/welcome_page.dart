import 'package:flutter/material.dart';
import '../../utils/text_with_tap.dart';
import '../../utils/customButton.dart';
import 'register_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/login.png",
                  height: 300,
                ),
                const TextWithTap(
                  "Vamos começar",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                const TextWithTap(
                  "Nunca é um momento melhor do que começar",
                  fontSize: 14,
                  color: Colors.black38,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  marginBottom: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    text: "Vamos começar",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
