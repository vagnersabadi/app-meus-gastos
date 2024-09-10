import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  Future<String> createLoginWithEmailAndPassword(String email, String password) async {
    final firebaseAuth = FirebaseAuth.instance;
    String message = '';

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
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

  Future<String> loginWithEmailAndPassword(String email, String password) async {
    final firebaseAuth = FirebaseAuth.instance;
    String message = '';

    try {
      await firebaseAuth.signInWithEmailAndPassword(
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
}
