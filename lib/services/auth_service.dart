import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/services/local_database_service.dart';
import 'package:task_management_app/services/realtime_database_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final RealtimeDatabaseService _realtimeDatabaseService = RealtimeDatabaseService();
  final LocalDatabaseService _localDatabaseService = LocalDatabaseService();

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
          await _realtimeDatabaseService.insert(userModel);
          await _localDatabaseService.insert('users', userModel.toMap());
        } catch (e) {
          rethrow;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
