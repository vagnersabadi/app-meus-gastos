import 'package:meus_gastos/src/core/model/login/login.model.dart';
import 'package:meus_gastos/src/core/services/firebase/firebase.service.dart';

class LoginService {
  FirebaseService firebaseService = FirebaseService();

  Future<LoginResult> createLoginWithEmailAndPassword(String email, String password) async {
    String message = await firebaseService.createLoginWithEmailAndPassword(email, password);

    return LoginResult(success: message.isEmpty, message: message);
  }

  Future<LoginResult> loginWithEmailAndPassword(String email, String password) async {
    String message = await firebaseService.loginWithEmailAndPassword(email, password);

    return LoginResult(success: message.isEmpty, message: message);
  }
}
