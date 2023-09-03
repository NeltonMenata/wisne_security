import 'package:cloud_firestore/cloud_firestore.dart';
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
  final auth = AuthControllerFirebase.instance;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final user = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil do Usuário")),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Nome"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: firstController,
                decoration: const InputDecoration(
                    hintText: "Digite aqui o seu Primeiro nome"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sobrenome"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: lastController,
                decoration: const InputDecoration(
                    hintText: "Digite aqui o seu Ultimo nome"),
              ),
            ),
            Padding(
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
                                      "Prencha todos os campos corretamente!")));
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.grey,
                                content: Text("Salvando, por favor aguarde!")));
                        final userUpdate = FirebaseFirestore.instance
                            .collection("User")
                            .doc("${user["id"]}");
                        userUpdate.set({
                          "name": firstController.text,
                          "lastName": lastController.text,
                        }, SetOptions(merge: true)).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Dados salvos com sucesso!"),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, Routes.HOME,
                              arguments: {
                                "id": user["id"],
                                "name": firstController.text,
                                "lastName": lastController.text,
                                "phoneNumber": user["phoneNumber"],
                              });
                        });
                      })),
            )
          ]),
    );
  }
}
