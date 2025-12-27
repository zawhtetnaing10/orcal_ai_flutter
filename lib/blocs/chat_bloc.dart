import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/actions/chat_actions.dart';
import 'package:orcal_ai_flutter/data/repository/orcal_repository.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/chat_message.dart';
import 'package:orcal_ai_flutter/network/responses/chat_response.dart';
import 'package:orcal_ai_flutter/states/chat_state.dart';
import 'package:orcal_ai_flutter/utils/constants.dart';
import 'package:orcal_ai_flutter/utils/date_utils.dart';

class ChatBloc extends Cubit<ChatState> {
  OrcalRepository repo = OrcalRepository();

  ChatBloc() : super(ChatState()) {
    /// Get Last 10 messages and update last doc.
    loadChatMessages(onComplete: () {});
  }

  void onAction(ChatActions action) async {
    switch (action) {
      case OnUserMessageChanged():
        emit(state.copyWith(userMessage: action.userMessage));
        break;
      case OnTapSendUserMessage():
        await handleSendMessage();
        break;
      case OnChatListEndReached():
        if (state.hasReachedEnd) {
          return;
        }
        handleLoadMoreMessages();
        break;
      case OnTapLogout():
        emit(state.copyWith(events: ChatEvents.showLogoutDialog));
        break;
      case OnTapConfirmLogout():
        await handleLogout();
        break;
      case OnTapEditKnowledgeBase():
        emit(state.copyWith(events: ChatEvents.navigateToKnowledgeBase));
        emit(state.copyWith(events: ChatEvents.initial));
        break;
      case OnDismissDialog():
        emit(state.copyWith(events: ChatEvents.initial));
        break;
    }
  }

  Future<void> handleLogout() async {
    try {
      await repo.logOut();
      emit(state.copyWith(events: ChatEvents.navigateToLogin));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          events: ChatEvents.showError,
          errorMessage: "Error logging out $e",
        ),
      );
    }
  }

  void handleLoadMoreMessages() {
    try {
      if (!state.isLoadingMoreMessages) {
        /// Show Load More
        emit(state.copyWith(isLoadingMoreMessages: true));

        /// Get Another 10 messages
        loadChatMessages(
          onComplete: () {
            /// Hide Load More
            emit(state.copyWith(isLoadingMoreMessages: false));
          },
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          events: ChatEvents.showError,
          errorMessage: "Error loading more chat $e",
        ),
      );
    }
  }

  Future<void> handleSendMessage() async {
    try {
      /// Show Chat Loading
      emit(state.copyWith(isAILoading: true));

      /// Temp store userMessage
      String userMessage = state.userMessage;

      /// Clear Chat message after pressing send
      emit(state.copyWith(userMessage: ""));

      /// Create Chat message object for user
      ChatMessage userMessageObj = ChatMessage(
        id: repo.getCurrentUserUid(),
        speaker: kSpeakerUser,
        content: userMessage,
        timestamp: getCurrentTimeMilliseconds(),
      );

      /// Add the object to state and emit
      addNewChatMessageAndEmit(userMessageObj);

      /// Make api call for chat
      ChatResponse llmResponse = await repo.chat(userMessage);

      /// Hide Chat Loading
      emit(state.copyWith(isAILoading: false));

      /// Create Chat message object for llm response
      ChatMessage aiMessageObj = ChatMessage(
        id: repo.getCurrentUserUid(),
        speaker: kSpeakerModel,
        content: llmResponse.response,
        timestamp: getCurrentTimeMilliseconds(),
      );

      /// Add the chat response to state and emit
      addNewChatMessageAndEmit(aiMessageObj);
    } on Exception catch (e) {
      emit(
        state.copyWith(
          events: ChatEvents.showError,
          errorMessage: "Error sending message $e",
        ),
      );
    }
  }

  void loadChatMessages({required Function onComplete}) {
    repo.getLatestMessages(lastDocument: state.lastDocument).then((
      messagesAndLastDoc,
    ) {
      List<ChatMessage> messages = messagesAndLastDoc.$1;
      DocumentSnapshot? lastDoc = messagesAndLastDoc.$2;

      /// If messages are empty, there's no reason to load more.
      if (messages.isEmpty) {
        emit(state.copyWith(hasReachedEnd: true));
        onComplete();
        return;
      }

      emit(state.copyWith(messages: messages, lastDocument: lastDoc));
      onComplete();
    });
  }

  void addNewChatMessageAndEmit(ChatMessage userMessageObj) {
    List<ChatMessage> currentMessages = state.messages;
    currentMessages.add(userMessageObj);
    emit(state.copyWith(messages: currentMessages));
  }
}
