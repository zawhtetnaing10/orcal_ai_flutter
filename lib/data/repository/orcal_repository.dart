import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orcal_ai_flutter/data/knowledge_base_cache/knowledge_base_cache.dart';
import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/chat_message.dart';
import 'package:orcal_ai_flutter/network/firebase/firebase_service.dart';
import 'package:orcal_ai_flutter/network/orcal_api_client.dart';
import 'package:orcal_ai_flutter/network/requests/build_embeddings_request.dart';
import 'package:orcal_ai_flutter/network/requests/chat_request.dart';
import 'package:orcal_ai_flutter/network/requests/register_request.dart';
import 'package:orcal_ai_flutter/network/responses/chat_response.dart';
import 'package:orcal_ai_flutter/network/responses/generic_response.dart';
import 'package:orcal_ai_flutter/network/retrofit_provider.dart';
import 'package:orcal_ai_flutter/utils/constants.dart';

class OrcalRepository {
  /// Singleton
  static final OrcalRepository _instance = OrcalRepository._internal();

  OrcalRepository._internal();

  factory OrcalRepository() {
    return _instance;
  }

  /// Rest Api
  final OrcalApiClient _client = RetrofitProvider().apiClient;

  /// Firebase
  final FirebaseService _firebaseService = FirebaseService();

  Future<User?> signIn(String email, String password) {
    return _firebaseService.signIn(email, password);
  }

  Future<User?> register(String email, String password, String username) async {
    RegisterRequest request = RegisterRequest(
      email: email,
      password: password,
      username: username,
    );
    await _client.register(request);
    return signIn(email, password);
  }

  /// Checks if user is logged in
  bool isUserLoggedIn() {
    return _firebaseService.isUserLoggedIn();
  }

  /// Checks if knowledge base has been built for this user
  Future<bool> isKnowledgeBaseBuilt() {
    return _firebaseService.isKnowledgeBaseBuilt();
  }

  Future<GenericResponse> buildEmbeddings() async {
    /// Get information to embed from knowledge base
    List<InfoToEmbedVO> infoToEmbed = KnowledgeBaseCache()
        .knowledgeBaseCache
        .values
        .toList();
    if (infoToEmbed.length < kNumberOfInfoToEmbed) {
      return Future.error(
        "There are missing answers. Please answer all the questions to build the complete knowledge base.",
      );
    }

    BuildEmbeddingsRequest request = BuildEmbeddingsRequest(data: infoToEmbed);
    String idToken = await _firebaseService.getBearerToken();
    return _client.buildEmbeddings(idToken, request);
  }

  Future<ChatResponse> chat(String message) async {
    ChatRequest request = ChatRequest(query: message);
    String idToken = await _firebaseService.getBearerToken();
    return _client.chat(idToken, request);
  }

  /// Get Latest Messages from firestore. Pagination handled.
  Future<(List<ChatMessage>, DocumentSnapshot?)> getLatestMessages({
    DocumentSnapshot? lastDocument,
  }) {
    return _firebaseService.getLatestMessages(lastDocument: lastDocument);
  }
}
