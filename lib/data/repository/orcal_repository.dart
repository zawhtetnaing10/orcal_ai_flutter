import 'package:firebase_auth/firebase_auth.dart';
import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';
import 'package:orcal_ai_flutter/network/firebase/firebase_service.dart';
import 'package:orcal_ai_flutter/network/orcal_api_client.dart';
import 'package:orcal_ai_flutter/network/requests/build_embeddings_request.dart';
import 'package:orcal_ai_flutter/network/requests/chat_request.dart';
import 'package:orcal_ai_flutter/network/requests/register_request.dart';
import 'package:orcal_ai_flutter/network/responses/generic_response.dart';
import 'package:orcal_ai_flutter/network/responses/user_response.dart';
import 'package:orcal_ai_flutter/network/retrofit_provider.dart';

class OrcalRepository {
  /// Rest Api
  final OrcalApiClient _client = RetrofitProvider().apiClient;

  /// Firebase
  final FirebaseService _firebaseService = FirebaseService();

  Future<User?> signIn(String email, String password) {
    return _firebaseService.signIn(email, password);
  }

  Future<UserResponse> register(
    String email,
    String password,
    String username,
  ) {
    RegisterRequest request = RegisterRequest(
      email: email,
      password: password,
      username: username,
    );
    return _client.register(request);
  }

  Future<GenericResponse> buildEmbeddings(
    List<InfoToEmbedVO> infoToEmbed,
  ) async {
    BuildEmbeddingsRequest request = BuildEmbeddingsRequest(data: infoToEmbed);
    String idToken = await _firebaseService.getBearerToken();
    return _client.buildEmbeddings(idToken, request);
  }

  Future<GenericResponse> chat(String message) async {
    ChatRequest request = ChatRequest(query: message);
    String idToken = await _firebaseService.getBearerToken();
    return _client.chat(idToken, request);
  }
}
