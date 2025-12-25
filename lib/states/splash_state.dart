class SplashState {
  SplashEvents event;

  SplashState({this.event = SplashEvents.initial});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashState &&
          runtimeType == other.runtimeType &&
          event == other.event;

  @override
  int get hashCode => event.hashCode;

  @override
  String toString() {
    return 'SplashState{event: $event}';
  }

  SplashState copyWith({SplashEvents? event}) {
    return SplashState(event: event ?? this.event);
  }
}

enum SplashEvents {
  initial,
  navigateToLogin,
  navigateToHome,
  navigateToAddKnowledgeBase,
}
