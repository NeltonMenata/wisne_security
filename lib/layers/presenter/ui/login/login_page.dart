import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Container(
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/logo/back.jpg",
                ),
                fit: BoxFit.cover),
            // gradient: LinearGradient(
            //   colors: [Colors.green, Colors.black],
            // ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/logo/logo1.png",
                  height: 200,
                  width: 200,
                ),
              ),
              // CircleAvatar(
              //   child: Image.asset("assets/logo/logo.png"),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  height: size.height * .5,
                  width: size.width * .8,
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        hintText: "Senha",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Login")),
                    ),
                    TextButton(onPressed: () {}, child: Text("Cadastra-se")),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Esquece a minha senha!",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ]),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
