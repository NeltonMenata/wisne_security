import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection("security").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Erro ao buscar dados");
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 1,
                          itemBuilder: (_, index) {
                            return Text(
                                "${snapshot.data?.docs[index].data().toString()}");
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            )
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
