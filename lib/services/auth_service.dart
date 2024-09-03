import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel? _checkUser(User? user) {
    if (user != null) {
      UserModel(uid: user.uid);
    }
    return null;
  }

  Stream<UserModel?> userAuthentication() {
    return _firebaseAuth.authStateChanges().map(_checkUser);
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password, UserModel userModel) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }
}
