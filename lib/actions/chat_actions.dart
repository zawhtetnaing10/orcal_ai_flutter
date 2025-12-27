sealed class ChatActions {}

class OnUserMessageChanged extends ChatActions {
  String userMessage;

  OnUserMessageChanged({required this.userMessage});
}

class OnTapSendUserMessage extends ChatActions {}

class OnChatListEndReached extends ChatActions {}

class OnTapLogout extends ChatActions {}

class OnTapEditKnowledgeBase extends ChatActions {}

class OnDismissDialog extends ChatActions {}
