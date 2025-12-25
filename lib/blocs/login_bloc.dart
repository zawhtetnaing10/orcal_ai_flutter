import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/actions/login_actions.dart';
import 'package:orcal_ai_flutter/data/repository/orcal_repository.dart';
import 'package:orcal_ai_flutter/mixins/check_knowldge_base_mixin.dart';
import 'package:orcal_ai_flutter/states/login_state.dart';

class LoginBloc extends Cubit<LoginState> with CheckKnowledgeBaseMixin {
  LoginBloc() : super(LoginState());

  final repo = OrcalRepository();

  void onAction(LoginActions action) async {
    switch (action) {
      case OnEmailChanged():
        emit(state.copyWith(email: action.email));
        break;
      case OnPasswordChanged():
        emit(state.copyWith(password: action.password));
        break;
      case OnTapLogin():
        if (state.email.isEmpty) {
          emit(
            state.copyWith(
              status: LoginEvents.showError,
              errorMessage: "Email cannot be empty",
            ),
          );
          return;
        }

        if (state.password.isEmpty) {
          emit(
            state.copyWith(
              status: LoginEvents.showError,
              errorMessage: "Password cannot be empty",
            ),
          );
          return;
        }

        emit(state.copyWith(status: LoginEvents.showLoading));
        try {
          await repo.signIn(state.email, state.password);
          emit(state.copyWith(status: LoginEvents.dismissLoading));

          checkKnowledgeBase(repo: repo, onKBBuilt: (){
            emit(state.copyWith(status: LoginEvents.navigateToHome));
          }, onKBNotBuilt: (){
            emit(state.copyWith(status: LoginEvents.navigateToKnowledgeBase));
          });

        } on Exception catch (e) {
          emit(state.copyWith(status: LoginEvents.dismissLoading));
          emit(
            state.copyWith(
              status: LoginEvents.showError,
              errorMessage: "Login failed: $e",
            ),
          );
        }
      case OnDismissDialog():
        emit(state.copyWith(status: LoginEvents.initial));
        break;
      case OnTapSignUp():
        emit(state.copyWith(status: LoginEvents.navigateToRegister));
        emit(state.copyWith(status: LoginEvents.initial));
        break;
    }
  }
}
