sealed class AddKnowledgeBaseTwoActions {}

class OnTechSkillsAndToolsAnswerChanged extends AddKnowledgeBaseTwoActions {
  String techSkillsAndToolsAnswer;

  OnTechSkillsAndToolsAnswerChanged({required this.techSkillsAndToolsAnswer});
}

class OnTopThreeProfessionalGoalsAnswerChanged
    extends AddKnowledgeBaseTwoActions {
  Map<int, String> topThreeProfessionalGoalsAnswer;

  OnTopThreeProfessionalGoalsAnswerChanged({
    required this.topThreeProfessionalGoalsAnswer,
  });
}

class OnMostProductiveTimeChanged extends AddKnowledgeBaseTwoActions {
  String mostProductiveTime;

  OnMostProductiveTimeChanged({required this.mostProductiveTime});
}

class OnTapNext extends AddKnowledgeBaseTwoActions {}

class OnAddKnowledgeBaseTwoDismissDialog extends AddKnowledgeBaseTwoActions {}
