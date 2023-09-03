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
    return await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {},
        verificationFailed: (exception) {
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
                Navigator.pushReplacementNamed(context, Routes.EDIT_USER,
                    arguments: {"id": value1.id, "phoneNumber": phoneNumber});
              });
            } else {
              final data = value.docs[0];
              final user = data.data();
              Navigator.pushReplacementNamed(context, Routes.HOME, arguments: {
                "name": user["name"],
                "lastName": user["lastName"],
                "phoneNumber": user["phoneNumber"]
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
