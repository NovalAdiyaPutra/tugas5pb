import 'package:flutter/material.dart';
import 'user_prefs.dart';
import 'home_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    final user = await UserPrefs.getUser();
    return user['email'] != '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return snapshot.data! ? HomeScreen() : LoginScreen();
        },
      ),
    );
  }
}
