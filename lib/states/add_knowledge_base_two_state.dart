class AddKnowledgeBaseTwoState {
  String techSkillsAndTools;
  Map<int, String> topThreeProfessionalGoals;
  String mostProductiveTime;
  String errorMessage;
  AddKnowledgeBaseTwoEvents events;

  AddKnowledgeBaseTwoState({
    this.techSkillsAndTools = "",
    this.topThreeProfessionalGoals = const {},
    this.mostProductiveTime = "",
    this.errorMessage = "",
    this.events = AddKnowledgeBaseTwoEvents.initial,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddKnowledgeBaseTwoState &&
          runtimeType == other.runtimeType &&
          techSkillsAndTools == other.techSkillsAndTools &&
          topThreeProfessionalGoals == other.topThreeProfessionalGoals &&
          mostProductiveTime == other.mostProductiveTime &&
          errorMessage == other.errorMessage &&
          events == other.events;

  @override
  int get hashCode =>
      techSkillsAndTools.hashCode ^
      topThreeProfessionalGoals.hashCode ^
      mostProductiveTime.hashCode ^
      errorMessage.hashCode ^
      events.hashCode;

  @override
  String toString() {
    return 'AddKnowledgeBaseTwoState(techSkillsAndTools: $techSkillsAndTools, topThreeProfessionalGoals: $topThreeProfessionalGoals, mostProductiveTime: $mostProductiveTime, errorMessage: $errorMessage, events: $events)';
  }

  AddKnowledgeBaseTwoState copyWith({
    String? techSkillsAndTools,
    Map<int, String>? topThreeProfessionalGoals,
    String? mostProductiveTime,
    String? errorMessage,
    AddKnowledgeBaseTwoEvents? events,
  }) {
    return AddKnowledgeBaseTwoState(
      techSkillsAndTools: techSkillsAndTools ?? this.techSkillsAndTools,
      topThreeProfessionalGoals:
          topThreeProfessionalGoals ?? this.topThreeProfessionalGoals,
      mostProductiveTime: mostProductiveTime ?? this.mostProductiveTime,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }
}

enum AddKnowledgeBaseTwoEvents {
  initial,
  showLoading,
  dismissLoading,
  navigateToStepThree,
  showError,
}
