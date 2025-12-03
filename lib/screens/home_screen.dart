import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO:- Login with Firebase
          },
          child: Text("Login with Firebase"),
        ),
      ),
    );
  }
}
