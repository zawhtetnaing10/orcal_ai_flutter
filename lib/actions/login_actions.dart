sealed class LoginActions {}

class OnEmailChanged extends LoginActions {
  final String email;

  OnEmailChanged(this.email);
}

class OnPasswordChanged extends LoginActions {
  final String password;

  OnPasswordChanged(this.password);
}

class OnDismissDialog extends LoginActions{}

class OnTapLogin extends LoginActions {}

class OnTapSignUp extends LoginActions {}
