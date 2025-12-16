// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_to_embed_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoToEmbedVO _$InfoToEmbedVOFromJson(Map<String, dynamic> json) =>
    InfoToEmbedVO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$InfoToEmbedVOToJson(InfoToEmbedVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
    };
