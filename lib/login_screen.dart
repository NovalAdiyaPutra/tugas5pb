import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user_prefs.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleLogin(BuildContext context) async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        await UserPrefs.saveUser(account.displayName ?? '', account.email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      print("Login error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.login),
          label: Text("Login with Google"),
          onPressed: () => handleLogin(context),
        ),
      ),
    );
  }
}
