import 'dart:math';

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
    emit(state.copyWith(events: ChatEvents.showLoading));
    loadChatMessages(
      onComplete: () {
        emit(state.copyWith(events: ChatEvents.dismissLoading));
        _scrollToBottom();
      },
    );

    /// Get Logged In User
    repo
        .getLoggedInUser()
        .then((user) {
          emit(state.copyWith(user: user));
        })
        .catchError((error) {
          emit(
            state.copyWith(
              events: ChatEvents.showError,
              isAILoading: false,
              isLoadingMoreMessages: false,
              errorMessage: "$e",
            ),
          );
        });
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
        repo
            .getLatestMessages(lastDocument: state.lastDocument)
            .then((messagesAndLastDoc) {
          List<ChatMessage> messages = messagesAndLastDoc.$1;
          DocumentSnapshot? lastDoc = messagesAndLastDoc.$2;

          /// If messages are empty, there's no reason to load more.
          if (messages.isEmpty) {
            emit(state.copyWith(hasReachedEnd: true));
            emit(state.copyWith(isLoadingMoreMessages: false));
            return;
          }

          /// Add new messages to the start of the current list.
          List<ChatMessage> currentMessages = state.messages.toList();
          currentMessages.insertAll(0, messages);

          emit(state.copyWith(messages: currentMessages, lastDocument: lastDoc));
          emit(state.copyWith(isLoadingMoreMessages: false));
        })
            .catchError((error) {
          emit(state.copyWith(events: ChatEvents.dismissLoading));
          emit(
            state.copyWith(
              events: ChatEvents.showError,
              isAILoading: false,
              isLoadingMoreMessages: false,
              errorMessage:
              "Something went wrong while fetching the chat messages : $error",
            ),
          );
        });
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
    if (state.userMessage.isEmpty) {
      emit(
        state.copyWith(
          events: ChatEvents.showError,
          errorMessage: "Message cannot be empty.",
        ),
      );
      return;
    }

    try {
      /// Show Chat Loading
      emit(state.copyWith(isAILoading: true));

      _scrollToBottom();

      /// Temp store userMessage
      String userMessage = state.userMessage;

      /// Clear Chat message after pressing send
      emit(state.copyWith(events: ChatEvents.clearChatBox));

      /// Create Chat message object for user
      ChatMessage userMessageObj = ChatMessage(
        id: repo.getCurrentUserUid(),
        speaker: kSpeakerUser,
        content: userMessage,
        timestamp: getCurrentTimeMilliseconds(),
      );

      /// Add the object to state and emit
      _addNewChatMessageAndEmit(userMessageObj);

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
      _addNewChatMessageAndEmit(aiMessageObj);

      /// Scroll list to bottom.
      _scrollToBottom();
    } on Exception catch (e) {
      emit(
        state.copyWith(
          events: ChatEvents.showError,
          isAILoading: false,
          isLoadingMoreMessages: false,
          errorMessage: "Error sending message $e",
        ),
      );
    }
  }

  void loadChatMessages({required Function onComplete}) {
    repo
        .getLatestMessages(lastDocument: state.lastDocument)
        .then((messagesAndLastDoc) {
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
        })
        .catchError((error) {
          emit(state.copyWith(events: ChatEvents.dismissLoading));
          emit(
            state.copyWith(
              events: ChatEvents.showError,
              isAILoading: false,
              isLoadingMoreMessages: false,
              errorMessage:
                  "Something went wrong while fetching the chat messages : $error",
            ),
          );
        });
  }

  void _scrollToBottom() {
    emit(state.copyWith(events: ChatEvents.scrollToBottom));
    emit(state.copyWith(events: ChatEvents.initial));
  }

  void _addNewChatMessageAndEmit(ChatMessage userMessageObj) {
    List<ChatMessage> currentMessages = state.messages.toList();
    currentMessages.add(userMessageObj);
    emit(state.copyWith(messages: currentMessages));
  }
}
