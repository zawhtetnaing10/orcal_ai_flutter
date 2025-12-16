import 'package:json_annotation/json_annotation.dart';

part 'info_to_embed_vo.g.dart';

@JsonSerializable()
class InfoToEmbedVO {
  final int id;
  final String title;
  final String details;

  const InfoToEmbedVO({
    required this.id,
    required this.title,
    required this.details,
  });

  factory InfoToEmbedVO.fromJson(Map<String, dynamic> json) =>
      _$InfoToEmbedVOFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToEmbedVOToJson(this);
}