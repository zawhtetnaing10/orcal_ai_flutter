import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/actions/add_knowledge_base_one_actions.dart';
import 'package:orcal_ai_flutter/data/knowledge_base_cache/knowledge_base_cache.dart';
import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';
import 'package:orcal_ai_flutter/states/add_knowledge_base_one_state.dart';
import 'package:orcal_ai_flutter/utils/knowlege_base_constants.dart';

class AddKnowledgeBaseOneBloc extends Cubit<AddKnowledgeBaseOneState> {
  AddKnowledgeBaseOneBloc() : super(AddKnowledgeBaseOneState());

  void onAction(AddKnowledgeBaseOneActions action) {
    switch (action) {
      case OnIdentityAnswerChanged():
        emit(state.copyWith(identity: action.identityAnswer));
        break;
      case OnWorkPersonaAnswerChanged():
        emit(state.copyWith(professionalPersona: action.workPersonaAnswer));
        break;
      case OnTimezoneAnswerChanged():
        emit(state.copyWith(timezone: action.timezoneAnswer));
        break;
      case OnAddKnowledgeBaseOneDismissDialog():
        emit(state.copyWith(events: AddKnowledgeBaseOneEvents.initial));
        break;
      case OnTapNext():
        if (state.identity.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseOneEvents.showError,
              errorMessage: "Please fill in your full name and nick name.",
            ),
          );
          return;
        }

        if (state.professionalPersona.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseOneEvents.showError,
              errorMessage: "Please fill in your professional persona.",
            ),
          );
          return;
        }

        if (state.timezone.isEmpty) {
          emit(
            state.copyWith(
              events: AddKnowledgeBaseOneEvents.showError,
              errorMessage: "Please select your timezone.",
            ),
          );
          return;
        }

        /// Build knowledge base objects
        Map<int, InfoToEmbedVO> infosToAdd = {};
        InfoToEmbedVO identityInfo = InfoToEmbedVO(
          id: 1,
          title: KbTitles.kQ1Identity,
          details: state.identity,
        );
        InfoToEmbedVO workPersonaInfo = InfoToEmbedVO(
          id: 2,
          title: KbTitles.kQ2ProfessionalPersona,
          details: state.professionalPersona,
        );
        InfoToEmbedVO timezoneInfo = InfoToEmbedVO(
          id: 3,
          title: KbTitles.kQ3LocalTimezone,
          details: state.timezone,
        );
        infosToAdd[identityInfo.id] = identityInfo;
        infosToAdd[workPersonaInfo.id] = workPersonaInfo;
        infosToAdd[timezoneInfo.id] = timezoneInfo;

        /// Save knowledge base objects in cache
        KnowledgeBaseCache().clearInfoToEmbed();
        KnowledgeBaseCache().addInfoToEmbedMultiple(infosToAdd);

        /// Navigate to step two
        emit(
          state.copyWith(events: AddKnowledgeBaseOneEvents.navigateToStepTwo),
        );
        emit(state.copyWith(events: AddKnowledgeBaseOneEvents.initial));
    }
  }
}
