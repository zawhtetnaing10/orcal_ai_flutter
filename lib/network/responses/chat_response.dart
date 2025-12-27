import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  final String response;

  const ChatResponse({required this.response});

  /// Connect the generated [_$ChatResponseFromJson] function to the factory
  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  /// Connect the generated [_$ChatResponseToJson] function to the method
  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
