import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/chat_message.dart';

class ChatState {
  final String userMessage;
  final List<ChatMessage> messages;
  final DocumentSnapshot? lastDocument;
  final bool isAILoading;
  final bool isLoadingMoreMessages;
  final bool hasReachedEnd;
  final String errorMessage;
  final ChatEvents events;

  ChatState({
    this.userMessage = "",
    this.messages = const [],
    this.lastDocument = null,
    this.isAILoading = false,
    this.isLoadingMoreMessages = false,
    this.hasReachedEnd = false,
    this.errorMessage = "",
    this.events = ChatEvents.initial,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ChatState && runtimeType == other.runtimeType &&
              userMessage == other.userMessage && messages == other.messages &&
              lastDocument == other.lastDocument &&
              isAILoading == other.isAILoading &&
              isLoadingMoreMessages == other.isLoadingMoreMessages &&
              hasReachedEnd == other.hasReachedEnd &&
              errorMessage == other.errorMessage && events == other.events;

  @override
  int get hashCode =>
      Object.hash(
          userMessage,
          messages,
          lastDocument,
          isAILoading,
          isLoadingMoreMessages,
          hasReachedEnd,
          errorMessage,
          events);


  @override
  String toString() {
    return 'ChatState{userMessage: $userMessage, messages: $messages, lastDocument: $lastDocument, isAILoading: $isAILoading, isLoadingMoreMessages: $isLoadingMoreMessages, hasReachedEnd: $hasReachedEnd, errorMessage: $errorMessage, events: $events}';
  }

  /// Creates a copy of this state with the given fields replaced by new values.
  ChatState copyWith({
    String? userMessage,
    List<ChatMessage>? messages,
    DocumentSnapshot? lastDocument,
    bool? isAILoading,
    bool? isLoadingMoreMessages,
    bool? hasReachedEnd,
    String? errorMessage,
    ChatEvents? events,
  }) {
    return ChatState(
      userMessage: userMessage ?? this.userMessage,
      messages: messages ?? this.messages,
      lastDocument: lastDocument ?? this.lastDocument,
      isAILoading: isAILoading ?? this.isAILoading,
      isLoadingMoreMessages: isLoadingMoreMessages ?? this.isLoadingMoreMessages,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }
}

enum ChatEvents {
  initial,
  showLoading,
  dismissLoading,
  showError,
  navigateToKnowledgeBase,
  showLogoutDialog,
  navigateToLogin,
}
