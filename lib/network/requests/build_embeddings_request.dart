import 'package:json_annotation/json_annotation.dart';
import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';

part 'build_embeddings_request.g.dart';

@JsonSerializable()
class BuildEmbeddingsRequest {
  final List<InfoToEmbedVO> data;

  const BuildEmbeddingsRequest({
    required this.data,
  });

  factory BuildEmbeddingsRequest.fromJson(Map<String, dynamic> json) =>
      _$BuildEmbeddingsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BuildEmbeddingsRequestToJson(this);
}