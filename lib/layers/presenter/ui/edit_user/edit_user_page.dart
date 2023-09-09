import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';
import 'package:wisne_security/layers/presenter/ui/auth/auth_firebase.dart';
import 'package:wisne_security/layers/presenter/utils/customButton.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final auth = AuthControllerFirebase.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil do Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Nome *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: firstController,
                    decoration: const InputDecoration(
                        hintText: "Digite aqui o seu Primeiro nome"),
                  ),
                ),
                SizedBox(
                  height: width * .08,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Sobrenome *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: lastController,
                    decoration: const InputDecoration(
                        hintText: "Digite aqui o seu Ultimo nome"),
                  ),
                ),
                SizedBox(
                  height: width * .15,
                ),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(
                //     "Email",
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextField(
                //     controller: emailController,
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: const InputDecoration(
                //         hintText: "Digite aqui o seu Email"),
                //   ),
                // ),
                // SizedBox(
                //   height: width * .15,
                // ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: width * .7,
                        child: CustomButton(
                            text: "Salvar",
                            onPressed: () {
                              if (firstController.text.isEmpty ||
                                  lastController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Prencha os campos obrigatórios (*) correctament!")));
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.grey,
                                      content: Text(
                                          "Salvando, por favor aguarde!")));

                              // if (emailController.text.isNotEmpty) {
                              //   FirebaseAuth.instance.currentUser
                              //       ?.updateEmail(emailController.text);
                              // }
                              FirebaseAuth.instance.currentUser
                                  ?.updateDisplayName(
                                      "${firstController.text} ${lastController.text}")
                                  .then((value) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Dados salvos com sucesso!"),
                                  ),
                                );
                                setState(() {
                                  firstController.text = "";
                                  lastController.text = "";
                                  emailController.text = "";
                                });
                                // Navigator.pushReplacementNamed(
                                //     context, Routes.HOME,
                                //     arguments: {
                                //       "id": user["id"],
                                //       "name": firstController.text,
                                //       "lastName": lastController.text,
                                //       "phoneNumber": user["phoneNumber"],
                                //     });
                              });
                            })),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
