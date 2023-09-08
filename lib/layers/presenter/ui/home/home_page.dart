import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisne_security/core/service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title = "Home Page"}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    final instance = FirebaseFirestore.instance;
    final collection = instance.collection("security");

    final result = await collection
        .add({"name": "wisne security", "contact": "$_counter"})
        .then((value) => print(value.id))
        .catchError((error) => print("Error: $error"));

    setState(() {
      _counter++;
    });
  }

  final user1 = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //final user = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Text(
              'Nome: ${FirebaseAuth.instance.currentUser}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Contacto: ${FirebaseAuth.instance.currentUser?.phoneNumber}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Text("User: "),
            Text("Error: ${AuthService.error}"),
            Text("SMS CODE: ${AuthService.smsCode}"),
            Text("${AuthService.id}")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
