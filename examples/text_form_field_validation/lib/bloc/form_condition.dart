/// Defines the behaviours for handling a forms condition.
///
/// type F is the forms submission failure type
/// type R is forms ready type
abstract class FormCondition<F, R> {
  /// returns a type B using either the given failure effect or ready effect
  B outcome<B>(B Function(F failure) failureEffect,
      B Function(R submission) readyEffect);

  /// returns a type B using either the given recover effect or continue effect
  B status<B>(B Function() recoverEffect, B Function() continueEffect);
}
