import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';

class UserPerfilPage extends StatefulWidget {
  const UserPerfilPage({Key? key}) : super(key: key);

  @override
  State<UserPerfilPage> createState() => _UserPerfilPageState();
}

class _UserPerfilPageState extends State<UserPerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(),
            accountName: Text(FirebaseAuth.instance.currentUser?.displayName ??
                "Edite o seu nome"),
            accountEmail: Text(FirebaseAuth.instance.currentUser?.email ??
                "Edite o seu email"),
          ),
          ListTile(
            title: const Text("Telefone"),
            subtitle: Text("${FirebaseAuth.instance.currentUser?.phoneNumber}"),
          ),
          const Spacer(),
          Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.EDIT_USER)
                        .then((value) => setState(() {}));
                  },
                  child: Text("Editar Perfil")))
        ],
      ),
    );
  }
}
