import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/actions/add_knowledge_base_three_actions.dart';
import 'package:orcal_ai_flutter/data/knowledge_base_cache/knowledge_base_cache.dart';
import 'package:orcal_ai_flutter/data/repository/orcal_repository.dart';
import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';
import 'package:orcal_ai_flutter/states/add_knowledge_base_three_state.dart';
import 'package:orcal_ai_flutter/utils/knowlege_base_constants.dart';

class AddKnowledgeBaseThreeBloc extends Cubit<AddKnowledgeBaseThreeState> {
  AddKnowledgeBaseThreeBloc() : super(AddKnowledgeBaseThreeState());

  OrcalRepository repository = OrcalRepository();

  void onAction(AddKnowledgeBaseThreeActions action) async {
    switch (action) {
      case OnTopicsCurrentlyLearningChanged():
        emit(
          state.copyWith(
            topicsCurrentlyLearning: action.topicsCurrentlyLearning,
          ),
        );
        break;
      case OnWorkBoundariesChanged():
        emit(state.copyWith(workBoundaries: action.workBoundaries));
        break;
      case OnAddKnowledgeBaseThreeDismissDialog():
        emit(state.copyWith(events: AddKnowledgeBaseThreeEvents.initial));
        break;
      case OnConfirmKnowledgeBaseSuccessful():
        emit(
          state.copyWith(events: AddKnowledgeBaseThreeEvents.navigateToHome),
        );
        break;
      case OnTapBuildKnowledgeBase():
        if (state.topicsCurrentlyLearning.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseThreeEvents.showError,
              errorMessage:
                  "Please fill in the topics you're currently learning.",
            ),
          );
          return;
        }

        if (state.workBoundaries.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseThreeEvents.showError,
              errorMessage: "Please fill in your work boundaries.",
            ),
          );
          return;
        }

        /// Build info to embed
        Map<int, InfoToEmbedVO> infoToEmbed = {};
        InfoToEmbedVO topicsCurrentlyLearningInfo = InfoToEmbedVO(
          id: 7,
          title: KbTitles.kQ7LearningInterests,
          details: state.topicsCurrentlyLearning,
        );
        InfoToEmbedVO workBoundariesInfo = InfoToEmbedVO(
          id: 8,
          title: KbTitles.kQ8WorkBoundaries,
          details: state.workBoundaries,
        );
        infoToEmbed[topicsCurrentlyLearningInfo.id] =
            topicsCurrentlyLearningInfo;
        infoToEmbed[workBoundariesInfo.id] = workBoundariesInfo;

        /// Save in cache
        KnowledgeBaseCache().addInfoToEmbedMultiple(infoToEmbed);

        /// Make the api call
        emit(state.copyWith(events: AddKnowledgeBaseThreeEvents.showLoading));

        try {
          /// Make build embeddings network call
          await repository.buildEmbeddings();

          /// Hide Loading and Show Success Dialog
          emit(
            state.copyWith(events: AddKnowledgeBaseThreeEvents.dismissLoading),
          );
          emit(
            state.copyWith(
              events: AddKnowledgeBaseThreeEvents.showSuccessDialog,
            ),
          );
        } on Exception catch (e) {
          emit(
            state.copyWith(events: AddKnowledgeBaseThreeEvents.dismissLoading),
          );
          emit(
            state.copyWith(
              events: AddKnowledgeBaseThreeEvents.showError,
              errorMessage: "Build embeddings failed: $e",
            ),
          );
        }
    }
  }
}
