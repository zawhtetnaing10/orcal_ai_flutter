import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/network/firebase/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orcal_ai_flutter/screens/add_knowledge_base_one_screen.dart';
import 'package:orcal_ai_flutter/screens/add_knowledge_base_three_screen.dart';
import 'package:orcal_ai_flutter/screens/add_knowledge_base_two_screen.dart';
import 'package:orcal_ai_flutter/screens/home_screen.dart';
import 'package:orcal_ai_flutter/screens/login_screen.dart';
import 'package:orcal_ai_flutter/screens/create_account_screen.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize both Firebase and its services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Router Set up
  final GoRouter _router = GoRouter(
    // TODO: - Change back after testing
    initialLocation: kLoginPath,
    routes: [
      GoRoute(
        path: kLoginPath,
        name: kLoginRoute,
        pageBuilder: createPageBuilder(const LoginScreen()),
      ),
      GoRoute(
        path: kRegisterPath,
        name: kRegisterRoute,
        pageBuilder: createPageBuilder(const CreateAccountScreen()),
      ),
      GoRoute(
        path: kAddKnowledgeBaseOnePath,
        name: kAddKnowledgeBaseOneRoute,
        pageBuilder: createPageBuilder(const AddKnowledgeBaseOneScreen()),
      ),
      GoRoute(
        path: kAddKnowledgeBaseTwoPath,
        name: kAddKnowledgeBaseTwoRoute,
        pageBuilder: createPageBuilder(const AddKnowledgeBaseTwoScreen()),
      ),
      GoRoute(
        path: kAddKnowledgeBaseThreePath,
        name: kAddKnowledgeBaseThreeRoute,
        pageBuilder: createPageBuilder(const AddKnowledgeBaseThreeScreen()),
      ),
      GoRoute(
        path : kHomePath,
        name: kHomeRoute,
        pageBuilder: createPageBuilder(const HomeScreen()),
      )
    ],
  );

  /// Returns the page level widget for go router together with page transition.
  static Page<dynamic> Function(BuildContext, GoRouterState)? createPageBuilder(Widget screenWidget){
    return (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: screenWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Orcal AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "PlusJarkataSans"),
    );
  }
}
