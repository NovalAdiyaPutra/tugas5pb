import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_prefs.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final data = await UserPrefs.getUser();
    print("=== LOAD USER ===");
    print("Nama: ${data['name']}");
    print("Email: ${data['email']}");
    setState(() {
      name = data['name']!;
      email = data['email']!;
    });
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await UserPrefs.clearUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Anda login sebagai", style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text(
                name.isNotEmpty ? name : "Loading...",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(email, style: TextStyle(fontSize: 18)),
              SizedBox(height: 40),
              if (email.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    onPressed: () => logout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[400],
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
