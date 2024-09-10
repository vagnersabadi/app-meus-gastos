import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  Future<String> createLogin(String email, String password) async {
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
      return message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login(String email, String password) async {
    final firebaseAuth = FirebaseAuth.instance;
    String message = '';

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return message;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return message;
    } catch (e) {
      return e.toString();
    }
  }
}
