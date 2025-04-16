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
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to App", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Text("Login with", style: TextStyle(fontSize: 16, color: Colors.blue[800])),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => handleLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("Google", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // optional: privacy policy action
              },
              child: Text("Privacy", style: TextStyle(color: Colors.blue[800])),
            ),
          ],
        ),
      ),
    );
  }
}
