import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/network/firebase/firebase_service.dart';
import 'package:orcal_ai_flutter/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orcal_ai_flutter/screens/login_screen.dart';
import 'package:orcal_ai_flutter/screens/register_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize both Firebase and its services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orcal AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "PlusJarkataSans",
      ),
      home: RegisterScreen(),
    );
  }
}
