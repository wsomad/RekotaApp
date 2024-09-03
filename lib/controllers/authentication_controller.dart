import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/services/auth_service.dart';

class AuthenticationController {
  final AuthService _authService = AuthService();

  static Future<bool> checkIfUserSignedIn() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // Offline
      return await _getLocalSignInStatus();
    }
    else {
      // Online
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _saveLocalSignInStatus(true);
        return true;
      }
      else {
        return false;
      }
    }
  }

  Future<void> signUp(String email, String password, String username, String role) async {
    UserModel userModel = UserModel(
      username: username,
      role: role,
    );
    try {
      User? user = await _authService.signUpWithEmailAndPassword(email, password, userModel);
      if (user != null) {
        await _saveLocalSignInStatus(true);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      User? user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        await _saveLocalSignInStatus(true);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> _getLocalSignInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isSignedIn') ?? false;
  }

  static Future<void> _saveLocalSignInStatus(bool status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isSignedIn', status);
  }
}