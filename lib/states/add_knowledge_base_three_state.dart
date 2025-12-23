class AddKnowledgeBaseThreeState {
  String topicsCurrentlyLearning;
  String workBoundaries;
  String errorMessage;
  AddKnowledgeBaseThreeEvents events;

  AddKnowledgeBaseThreeState({
    this.topicsCurrentlyLearning = "",
    this.workBoundaries = "",
    this.errorMessage = "",
    this.events = AddKnowledgeBaseThreeEvents.initial,
  });

  AddKnowledgeBaseThreeState copyWith({
    String? topicsCurrentlyLearning,
    String? workBoundaries,
    String? errorMessage,
    AddKnowledgeBaseThreeEvents? events,
  }) {
    return AddKnowledgeBaseThreeState(
      topicsCurrentlyLearning:
          topicsCurrentlyLearning ?? this.topicsCurrentlyLearning,
      workBoundaries: workBoundaries ?? this.workBoundaries,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddKnowledgeBaseThreeState &&
          runtimeType == other.runtimeType &&
          topicsCurrentlyLearning == other.topicsCurrentlyLearning &&
          workBoundaries == other.workBoundaries &&
          errorMessage == other.errorMessage &&
          events == other.events;

  @override
  int get hashCode =>
      topicsCurrentlyLearning.hashCode ^
      workBoundaries.hashCode ^
      errorMessage.hashCode ^
      events.hashCode;

  @override
  String toString() {
    return 'AddKnowledgeBaseThreeState(topicsCurrentlyLearning: $topicsCurrentlyLearning, workBoundaries: $workBoundaries, errorMessage: $errorMessage, events: $events)';
  }
}

enum AddKnowledgeBaseThreeEvents {
  initial,
  showLoading,
  dismissLoading,
  showSuccessDialog,
  navigateToHome,
  showError,
}
