class AddKnowledgeBaseOneState {
  String identity;
  String professionalPersona;
  String timezone;
  String errorMessage;
  AddKnowledgeBaseOneEvents events;

  AddKnowledgeBaseOneState({
    this.identity = "",
    this.professionalPersona = "",
    this.timezone = "",
    this.errorMessage = "",
    this.events = AddKnowledgeBaseOneEvents.initial,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddKnowledgeBaseOneState &&
          runtimeType == other.runtimeType &&
          identity == other.identity &&
          professionalPersona == other.professionalPersona &&
          timezone == other.timezone &&
          errorMessage == other.errorMessage &&
          events == other.events;

  @override
  int get hashCode =>
      identity.hashCode ^
      professionalPersona.hashCode ^
      timezone.hashCode ^
      errorMessage.hashCode ^
      events.hashCode;

  @override
  String toString() {
    return 'AddKnowledgeBaseOneState(identity: $identity, professionalPersona: $professionalPersona, timezone: $timezone, errorMessage: $errorMessage, events: $events)';
  }

  /// Creates a copy of this state but with the given fields replaced with the new values.
  AddKnowledgeBaseOneState copyWith({
    String? identity,
    String? professionalPersona,
    String? timezone,
    String? errorMessage,
    AddKnowledgeBaseOneEvents? events,
  }) {
    return AddKnowledgeBaseOneState(
      identity: identity ?? this.identity,
      professionalPersona: professionalPersona ?? this.professionalPersona,
      timezone: timezone ?? this.timezone,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }
}

enum AddKnowledgeBaseOneEvents {
  initial,
  showLoading,
  dismissLoading,
  navigateToStepTwo,
  showError,
}
