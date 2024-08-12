import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController {
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

  static Future<bool> _getLocalSignInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isSignedIn') ?? false;
  }

  static Future<void> _saveLocalSignInStatus(bool status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isSignedIn', status);
  }
}