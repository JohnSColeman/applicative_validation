/// Defines the behaviours for handling a forms condition.
///
/// type F is the forms submission failure type
/// type R is forms ready type - either unsubmitted or submitted and succeeded
abstract class FormCondition<F, R> {
  /// Handle the outcome of this forms submission, either for failure or ready.
  ///
  /// Returns a type B using either the given failure effect or ready effect
  B onOutcome<B>(
      B Function(F failure) failureEffect, B Function(R submission) readyEffect);

  /// Handle the current status of this form either for recovery or continuing.
  ///
  /// Returns a type B using either the given recover effect or continue effect
  B onStatus<B>(B Function() recoverEffect, B Function() continueEffect);
}
