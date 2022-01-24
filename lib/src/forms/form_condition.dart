part of applicative_validation_forms;

/// Defines the behaviours for handling a forms condition.
///
/// type F is the forms state type
abstract class FormCondition<F> {
  /// returns a type B using either the given ready effect or other effect
  B readied<B>(B Function(F) readyEffect, B Function(F, Iterable<Error>) otherEffect);

  /// returns a type B using either the given invalid effect or other effect
  B invalidated<B>(
      B Function(Iterable<ArgumentError>) invalidEffect, B Function() otherEffect);

  /// returns a type B using either the given warning effect or other effect
  B warned<B>(B Function(Iterable<SubmissionError>) warningEffect,
      B Function() otherEffect);

  /// returns a type B using either the given failure effect or other effect
  B failed<B>(B Function(Iterable<SubmissionError>) failureEffect,
      B Function() otherEffect);
}
