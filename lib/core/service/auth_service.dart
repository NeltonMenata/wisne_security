import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static String error = "";
  static String smsCode = "";
  static String id = "";
  static bool loading = false;

  static Future<void> verifyNumber(
      {required String phoneNumber, required Function next}) async {
    const maximumAttemptTime = Duration(seconds: 30);
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: maximumAttemptTime,
        verificationCompleted: (AuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
          next();
        },
        verificationFailed: (FirebaseAuthException exception) {
          error = exception.message.toString();
        },
        codeSent: (String verificationId, int? resendToken) async {
          id = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          id = verificationId;
        });
  }

  static Future<void> getVerificationId(Function next) async {
    try {
      final credential =
          PhoneAuthProvider.credential(verificationId: id, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(credential);
      next();
    } catch (e) {
      error = e.toString();
    }
  }
}
