class LoginState {
  final String email;
  final String password;
  final LoginEvents status;
  final String errorMessage;

  LoginState({
    this.email = "",
    this.password = "",
    this.status = LoginEvents.initial,
    this.errorMessage = "",
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          status == other.status &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(email, password, status, errorMessage);

  LoginState copyWith({
    String? email,
    String? password,
    LoginEvents? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// This is for navigation, showing loading, error, etc...
enum LoginEvents {
  initial,
  showLoading,
  navigateToHome,
  dismissLoading,
  showError,
  navigateToRegister,
}
