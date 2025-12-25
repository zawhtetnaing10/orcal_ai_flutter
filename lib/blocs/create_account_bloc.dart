import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcal_ai_flutter/actions/create_account_actions.dart';
import 'package:orcal_ai_flutter/data/repository/orcal_repository.dart';
import 'package:orcal_ai_flutter/states/create_account_state.dart';

class CreateAccountBloc extends Cubit<CreateAccountState> {
  CreateAccountBloc() : super(CreateAccountState());

  var repo = OrcalRepository();

  void onAction(CreateAccountActions action) async {
    switch (action) {
      case OnCreateAccountEmailChanged():
        emit(state.copyWith(email: action.email));
      case OnCreateAccountPasswordChanged():
        emit(state.copyWith(password: action.password));
      case OnCreateAccountUserNameChanged():
        emit(state.copyWith(userName: action.userName));
      case OnCreateAccountDismissDialog():
        emit(state.copyWith(event: CreateAccountEvents.initial));
      case OnTapCreateAccount():
        if (state.email.isEmpty) {
          emit(
            state.copyWith(
              event: CreateAccountEvents.showError,
              errorMessage: "Email cannot be empty",
            ),
          );
          return;
        }

        if (state.password.isEmpty) {
          emit(
            state.copyWith(
              event: CreateAccountEvents.showError,
              errorMessage: "Password cannot be empty",
            ),
          );
          return;
        }

        if (state.userName.isEmpty) {
          emit(
            state.copyWith(
              event: CreateAccountEvents.showError,
              errorMessage: "Username cannot be empty",
            ),
          );
          return;
        }

        try {
          emit(state.copyWith(event: CreateAccountEvents.showLoading));
          await repo.register(state.email, state.password, state.userName);
          emit(state.copyWith(event: CreateAccountEvents.dismissLoading));
          emit(state.copyWith(event: CreateAccountEvents.navigateToBuildKnowledgeBase));
        } on Exception catch (e) {
          emit(state.copyWith(event: CreateAccountEvents.dismissLoading));
          emit(
            state.copyWith(
              event: CreateAccountEvents.showError,
              errorMessage: "$e",
            ),
          );
        }

      case OnTapBack():
        emit(state.copyWith(event: CreateAccountEvents.navigateBack));
    }
  }
}
