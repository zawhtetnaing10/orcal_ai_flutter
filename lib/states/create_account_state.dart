class CreateAccountState {
  String email;
  String password;
  String userName;
  CreateAccountEvents event;
  String errorMessage;

  CreateAccountState({
    this.email = "",
    this.password = "",
    this.userName = "",
    this.event = CreateAccountEvents.initial,
    this.errorMessage = "",
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateAccountState &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          userName == other.userName &&
          event == other.event &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      Object.hash(email, password, userName, event, errorMessage);

  @override
  String toString() {
    return 'CreateAccountState{email: $email, password: $password, userName: $userName, event: $event, errorMessage: $errorMessage}';
  }

  CreateAccountState copyWith({
    String? email,
    String? password,
    String? userName,
    CreateAccountEvents? event,
    String? errorMessage,
  }) {
    return CreateAccountState(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      event: event ?? this.event,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum CreateAccountEvents {
  initial,
  showLoading,
  dismissLoading,
  navigateBack,
  navigateToBuildKnowledgeBase,
  showError,
}
