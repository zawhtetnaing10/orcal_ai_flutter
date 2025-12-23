sealed class AddKnowledgeBaseThreeActions {}

class OnTopicsCurrentlyLearningChanged extends AddKnowledgeBaseThreeActions {
  String topicsCurrentlyLearning;

  OnTopicsCurrentlyLearningChanged({required this.topicsCurrentlyLearning});
}

class OnWorkBoundariesChanged extends AddKnowledgeBaseThreeActions {
  String workBoundaries;

  OnWorkBoundariesChanged({required this.workBoundaries});
}

class OnTapBuildKnowledgeBase extends AddKnowledgeBaseThreeActions {}

class OnAddKnowledgeBaseThreeDismissDialog
    extends AddKnowledgeBaseThreeActions {}

class OnConfirmKnowledgeBaseSuccessful extends AddKnowledgeBaseThreeActions {}
