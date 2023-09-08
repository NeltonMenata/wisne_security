import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';

class AuthControllerFirebase {
  final auth = FirebaseAuth.instance;
  AuthControllerFirebase._();

  static AuthControllerFirebase? _auth;

  static AuthControllerFirebase get instance {
    if (_auth == null) {
      _auth = AuthControllerFirebase._();
      return _auth!;
    } else {
      return _auth!;
    }
  }

  Future<void> verifyNumber(BuildContext context, String phoneNumber) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Verificando o número, por favor aguarde!"),
      ),
    );
    return await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          print("Verification Completed");
          print("################################");
          print(credential);
        },
        verificationFailed: (exception) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Erro ao verificar, tente novamente!"),
            ),
          );
          print("error: ${exception.message}");
        },
        codeSent: (verificationId, resendToken) {
          final collection = FirebaseFirestore.instance.collection("User");
          collection
              .where("phoneNumber", isEqualTo: phoneNumber)
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              collection.add({"phoneNumber": phoneNumber}).then((value1) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.EDIT_USER,
                  arguments: {
                    "id": value1.id,
                    "phoneNumber": phoneNumber,
                    "code": resendToken,
                  },
                );
              });
            } else {
              
              final data = value.docs[0];
              final user = data.data();
              Navigator.pushReplacementNamed(context, Routes.HOME, arguments: {
                "name": user["name"],
                "lastName": user["lastName"],
                "phoneNumber": user["phoneNumber"],
                "code": resendToken,
              });
            }
          }).onError((error, stackTrace) {
            Navigator.pushReplacementNamed(context, Routes.OTP, arguments: {
              "id": verificationId,
              "numero": phoneNumber,
              "code": resendToken,
            });
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }
}
