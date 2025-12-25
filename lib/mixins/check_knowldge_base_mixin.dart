import 'dart:ui';

import 'package:orcal_ai_flutter/data/repository/orcal_repository.dart';

mixin CheckKnowledgeBaseMixin {
  void checkKnowledgeBase({
    required OrcalRepository repo,
    required VoidCallback onKBBuilt,
    required VoidCallback onKBNotBuilt,
  }) async {
    bool isKnowledgeBaseBuilt = await repo.isKnowledgeBaseBuilt();
    if (isKnowledgeBaseBuilt) {
      onKBBuilt();
    } else {
      onKBNotBuilt();
    }
  }

  void checkAuthAndKnowledgeBase({
    required OrcalRepository repo,
    required VoidCallback onNotLoggedIn,
    required VoidCallback onKBBuilt,
    required VoidCallback onKBNotBuilt,
  }) {
    if(repo.isUserLoggedIn()){
      checkKnowledgeBase(repo: repo, onKBBuilt: onKBBuilt, onKBNotBuilt: onKBNotBuilt);
    } else {
      onNotLoggedIn();
    }
  }
}
