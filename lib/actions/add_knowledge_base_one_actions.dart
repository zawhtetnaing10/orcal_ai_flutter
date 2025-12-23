sealed class AddKnowledgeBaseOneActions {}

class OnIdentityAnswerChanged extends AddKnowledgeBaseOneActions {
  String identityAnswer;

  OnIdentityAnswerChanged({required this.identityAnswer});
}

class OnWorkPersonaAnswerChanged extends AddKnowledgeBaseOneActions {
  String workPersonaAnswer;

  OnWorkPersonaAnswerChanged({required this.workPersonaAnswer});
}

class OnTimezoneAnswerChanged extends AddKnowledgeBaseOneActions {
  String timezoneAnswer;

  OnTimezoneAnswerChanged({required this.timezoneAnswer});
}

class OnTapNext extends AddKnowledgeBaseOneActions {}

class OnAddKnowledgeBaseOneDismissDialog extends AddKnowledgeBaseOneActions {}
