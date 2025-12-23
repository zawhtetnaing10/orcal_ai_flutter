import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/actions/add_knowledge_base_two_actions.dart';
import 'package:orcal_ai_flutter/data/knowledge_base_cache/knowledge_base_cache.dart';
import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';
import 'package:orcal_ai_flutter/states/add_knowledge_base_two_state.dart';
import 'package:orcal_ai_flutter/utils/knowlege_base_constants.dart';

class AddKnowledgeBaseTwoBloc extends Cubit<AddKnowledgeBaseTwoState> {
  AddKnowledgeBaseTwoBloc() : super(AddKnowledgeBaseTwoState());

  void onAction(AddKnowledgeBaseTwoActions action) {
    switch (action) {
      case OnTechSkillsAndToolsAnswerChanged():
        emit(
          state.copyWith(techSkillsAndTools: action.techSkillsAndToolsAnswer),
        );
        break;
      case OnTopThreeProfessionalGoalsAnswerChanged():
        emit(
          state.copyWith(
            topThreeProfessionalGoals: action.topThreeProfessionalGoalsAnswer,
          ),
        );
        break;
      case OnMostProductiveTimeChanged():
        emit(state.copyWith(mostProductiveTime: action.mostProductiveTime));
        break;
      case OnTapNext():
        if (state.techSkillsAndTools.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseTwoEvents.showError,
              errorMessage:
                  "Please fill in your preferred tech skills and tools",
            ),
          );
          return;
        }

        if (state.topThreeProfessionalGoals.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseTwoEvents.showError,
              errorMessage: "Please fill in your top three professional goals.",
            ),
          );
          return;
        }

        if (state.mostProductiveTime.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseTwoEvents.showError,
              errorMessage: "Please choose your most productive time.",
            ),
          );
          return;
        }

        /// Details for top three professional goals
        String topThreeProfessionalGoalsDetails = "";
        for (var entry in state.topThreeProfessionalGoals.entries) {
          topThreeProfessionalGoalsDetails += "${entry.key}.${entry.value}\n";
        }

        Map<int, InfoToEmbedVO> infosToAdd = {};
        InfoToEmbedVO techSkillInfo = InfoToEmbedVO(
          id: 4,
          title: KbTitles.kQ4TechnicalSkills,
          details: state.techSkillsAndTools,
        );
        InfoToEmbedVO topThreeProfessionalSkillsInfo = InfoToEmbedVO(
          id: 5,
          title: KbTitles.kQ5ProfessionalGoals,
          details: topThreeProfessionalGoalsDetails,
        );
        InfoToEmbedVO mostProductiveTimeInfo = InfoToEmbedVO(
          id: 6,
          title: KbTitles.kQ6ProductivityWindows,
          details: state.mostProductiveTime,
        );

        infosToAdd[techSkillInfo.id] = techSkillInfo;
        infosToAdd[topThreeProfessionalSkillsInfo.id] =
            topThreeProfessionalSkillsInfo;
        infosToAdd[mostProductiveTimeInfo.id] = mostProductiveTimeInfo;

        /// Save Knowledge in cache.
        KnowledgeBaseCache().addInfoToEmbedMultiple(infosToAdd);

        /// Emit events for navigation
        emit(
          state.copyWith(events: AddKnowledgeBaseTwoEvents.navigateToStepThree),
        );
        emit(state.copyWith(events: AddKnowledgeBaseTwoEvents.initial));

      case OnAddKnowledgeBaseTwoDismissDialog():
        emit(state.copyWith(events: AddKnowledgeBaseTwoEvents.initial));
        break;
    }
  }
}
