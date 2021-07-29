import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthService {
  GoogleAuthService._privateConstructor();
  static final GoogleAuthService instance =
      GoogleAuthService._privateConstructor();

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future verifyPhoneNumber(
      {required String phone,
      required Function(PhoneAuthCredential) onCompleted,
      required Function onFailed,
      required Function(String) onSent,
      required Function(String) onTimeOut}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: onCompleted,
          verificationFailed: (ex) {
            onFailed(ex);
          },
          codeSent: (verifiedId, _) {
            onSent(verifiedId);
          },
          codeAutoRetrievalTimeout: (verifiedId) {
            onTimeOut(verifiedId);
          },
          timeout: Duration(seconds: 30));
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<User?> signInByPhone(String verifiedId, String code) async {
    User? user;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifiedId, smsCode: code);

      user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    } catch (ex) {
      throw ex.toString();
    }
    return user;
  }

  Future<void> signOutPhone() async {
    if (currentUser != null) await FirebaseAuth.instance.signOut();
  }
}
