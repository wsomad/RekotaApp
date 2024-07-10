import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/controllers/user_controller.dart';
import 'package:task_management_app/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserController _userController = UserController();

  UserModel? _checkUser(User? user) {
    if (user != null) {
      UserModel(uid: user.uid);
    }
    return null;
  }

  Stream<UserModel?> userAuthentication() {
    return _firebaseAuth.authStateChanges().map(_checkUser);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, UserModel userModel) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? createUser = userCredential.user;

      if (createUser != null) {
        try {
          await _userController.create(userModel, createUser.uid);
        } catch (e) {
          rethrow;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
