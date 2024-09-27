import 'package:meus_gastos/src/core/models/login/login.model.dart';
import 'package:meus_gastos/src/core/services/firebase_auth/firebase_auth.service.dart';

class LoginService {

  Future<LoginResult> createLoginWithEmailAndPassword(String email, String password) async {
    String message = await FirebaseAuthService.createLoginWithEmailAndPassword(email, password);

    return LoginResult(success: message.isEmpty, message: message);
  }

  Future<LoginResult> loginWithEmailAndPassword(String email, String password) async {
    String message = await FirebaseAuthService.loginWithEmailAndPassword(email, password);

    return LoginResult(success: message.isEmpty, message: message);
  }
}
