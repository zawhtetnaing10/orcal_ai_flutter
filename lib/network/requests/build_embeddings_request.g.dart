// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_embeddings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildEmbeddingsRequest _$BuildEmbeddingsRequestFromJson(
  Map<String, dynamic> json,
) => BuildEmbeddingsRequest(
  data: (json['data'] as List<dynamic>)
      .map((e) => InfoToEmbedVO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BuildEmbeddingsRequestToJson(
  BuildEmbeddingsRequest instance,
) => <String, dynamic>{'data': instance.data};
