import 'package:dio/dio.dart';
import 'package:orcal_ai_flutter/network/requests/build_embeddings_request.dart';
import 'package:orcal_ai_flutter/network/requests/chat_request.dart';
import 'package:orcal_ai_flutter/network/requests/register_request.dart';
import 'package:orcal_ai_flutter/network/responses/chat_response.dart';
import 'package:orcal_ai_flutter/network/responses/generic_response.dart';
import 'package:orcal_ai_flutter/network/responses/user_response.dart';
import 'package:orcal_ai_flutter/utils/constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'orcal_api_client.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class OrcalApiClient {
  factory OrcalApiClient(Dio dio, {String? baseUrl}) = _OrcalApiClient;

  @POST(kEndpointRegister)
  Future<UserResponse> register(@Body() RegisterRequest request);

  @POST(kEndpointBuildEmbeddings)
  Future<GenericResponse> buildEmbeddings(
    @Header(kHeaderAuthorization) String authorization,
    @Body() BuildEmbeddingsRequest request,
  );

  @POST(kEndpointChat)
  Future<ChatResponse> chat(
    @Header(kHeaderAuthorization) String authorization,
    @Body() ChatRequest request,
  );
}
