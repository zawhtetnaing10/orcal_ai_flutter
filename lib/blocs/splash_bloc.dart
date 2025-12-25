import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/data/repository/orcal_repository.dart';
import 'package:orcal_ai_flutter/mixins/check_knowldge_base_mixin.dart';
import 'package:orcal_ai_flutter/states/splash_state.dart';
import 'package:orcal_ai_flutter/utils/constants.dart';

class SplashBloc extends Cubit<SplashState> with CheckKnowledgeBaseMixin {
  OrcalRepository repo = OrcalRepository();

  SplashBloc() : super(SplashState()) {
    checkAuthAndKnowledgeBase(
      repo: repo,
      onNotLoggedIn: () async {
        await Future.delayed(Duration(seconds: kSplashScreenWaitTime));
        emit(state.copyWith(event: SplashEvents.navigateToLogin));
      },
      onKBBuilt: () async {
        await Future.delayed(Duration(seconds: kSplashScreenWaitTime));
        emit(state.copyWith(event: SplashEvents.navigateToHome));
      },
      onKBNotBuilt: () async {
        await Future.delayed(Duration(seconds: kSplashScreenWaitTime));
        emit(state.copyWith(event: SplashEvents.navigateToAddKnowledgeBase));
      },
    );
  }
}
