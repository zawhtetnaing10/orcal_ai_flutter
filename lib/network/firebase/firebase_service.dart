import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/chat_message.dart';

class FirebaseService {
  // Singleton instance
  static final FirebaseService _instance = FirebaseService._internal();

  FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  // Services
  late final FirebaseAuth auth;
  late final FirebaseFirestore db;

  // Async Initialization
  Future<void> initialize() async {
    auth = FirebaseAuth.instance;
    db = FirebaseFirestore.instance;
    print('FirebaseService initialized successfully.');
  }

  /// Sign in with Email and Password
  Future<User?> signIn(String email, String password) async {
    if (email.isEmpty) {
      return Future.error("Email cannot be empty");
    }

    if (password.isEmpty) {
      return Future.error("Password cannot be empty");
    }

    UserCredential credentials = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  /// Check if user is logged in.
  bool isUserLoggedIn() {
    return auth.currentUser != null;
  }

  /// Get current user uid
  String getCurrentUserUid() {
    return auth.currentUser?.uid ?? "";
  }

  /// Get id token of the current user
  Future<String> getBearerToken() async {
    String? idToken = await auth.currentUser?.getIdToken();
    if (idToken != null) {
      return "Bearer $idToken";
    } else {
      return "";
    }
  }

  /// Checks if the user has already built the knowledge base
  Future<bool> isKnowledgeBaseBuilt() async {
    try {
      String uid = getCurrentUserUid();
      DocumentSnapshot snapshot = await db
          .collection("users")
          .doc(uid)
          .collection("config")
          .doc("rag_config")
          .get();

      if (!snapshot.exists) {
        return Future.error("Data does not exists");
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data["is_knowledge_base_built"] as bool? ?? false;
    } on Exception catch (e) {
      return Future.error("Error checking knowledge base $e");
    }
  }

  /// Get Latest Messages
  Stream<List<ChatMessage>> getLatestMessages() {
    String uid = getCurrentUserUid();

    Query query = db
        .collection("users")
        .doc(uid)
        .collection("chats")
        .doc("conversation")
        .collection("messages")
        .orderBy(FieldPath.documentId, descending: true)
        .limit(10);

    return query.snapshots().map((snapshot) {
      final messages = snapshot.docs
          .map(
            (doc) => ChatMessage.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
      return messages.reversed.toList();
    });
  }

  /// TODO: - Add another function to load more messages
}
