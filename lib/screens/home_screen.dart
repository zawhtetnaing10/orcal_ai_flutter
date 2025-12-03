import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            /// Get User
            User? user;
            if(auth.currentUser == null){
              var credentials = await auth.signInWithEmailAndPassword(
                  email: "zawgyi.gog@gmail.com", password: "zawhtetnaing1992");
              user = credentials.user;
            } else {
              user = auth.currentUser;
            }

            /// Get IdToken
            String idToken = await user?.getIdToken() ?? "Invalid token";
            print("The id token is $idToken");
          },
          child: Text("Login with Firebase"),
        ),
      ),
    );
  }
}
