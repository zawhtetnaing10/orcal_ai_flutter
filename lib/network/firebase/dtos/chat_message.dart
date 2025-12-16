import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String speaker;
  final String content;
  final int timestamp;

  ChatMessage({
    required this.id,
    required this.speaker,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessage.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ChatMessage(
      id: doc.id,
      speaker: data['speaker'] as String? ?? 'model',
      content: data['content'] as String? ?? '',
      timestamp: int.tryParse(doc.id) ?? 0,
    );
  }
}