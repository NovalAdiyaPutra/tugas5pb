import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user_prefs.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String email = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final data = await UserPrefs.getUser();
    setState(() {
      name = data['name']!;
      email = data['email']!;
    });
  }

  void logout(BuildContext context) async {
    await _googleSignIn.signOut();
    await UserPrefs.clearUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat Datang"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama: $name"),
            Text("Email: $email"),
          ],
        ),
      ),
    );
  }
}
