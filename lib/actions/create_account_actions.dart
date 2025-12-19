sealed class CreateAccountActions {}

class OnCreateAccountEmailChanged extends CreateAccountActions {
  final String email;

  OnCreateAccountEmailChanged(this.email);
}

class OnCreateAccountPasswordChanged extends CreateAccountActions {
  final String password;

  OnCreateAccountPasswordChanged(this.password);
}

class OnCreateAccountUserNameChanged extends CreateAccountActions {
  final String userName;

  OnCreateAccountUserNameChanged(this.userName);
}

class OnCreateAccountDismissDialog extends CreateAccountActions {}

class OnTapCreateAccount extends CreateAccountActions {}

class OnTapBack extends CreateAccountActions {}
