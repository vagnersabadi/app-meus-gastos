import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth? _firebaseAuth;

  static Future<void> _init() async {
    _firebaseAuth = FirebaseAuth.instance;
  }

  static Future<String> createLoginWithEmailAndPassword(
      String email, String password) async {
    String message = '';
    await _init();

    try {
      await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return message;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = 'Já existe uma conta com esse e-mail.';
      }
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    String message = '';
    await _init();

    try {
      await _firebaseAuth!.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return message;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = 'Já existe uma conta com esse e-mail.';
      }
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> logout() async {
    await _init();

    try {
      _firebaseAuth!.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
