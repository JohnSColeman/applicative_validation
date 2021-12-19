part of applicative_validation_framework;

/// Extension methods to give Either behaviours like Validated
extension EitherSemigroupApplicative<E, A> on Either<E, A> {
  /// combines this Either and other Either using the given semigroup
  Either<E, B> aps<B>(Either<E, B Function(A)> other, Semigroup<E> ee) {
    if (isRight() && other.isRight()) {
      return right(((other as Right).value as B Function(
          A))((this as Right).value as A));
    }
    if (isLeft() && other.isLeft()) {
      return left(
          ee.append((other as Left).value as E, (this as Left).value as E));
    }
    if (isLeft()) {
      return this as Left<E, B>;
    }
    return other.map((a) => a((this as Right).value as A));
  }

  /// transforms this Either to an Either with new types using given functions
  Either<E2, A2> bimap<E2, A2>(E2 Function(E) fe, A2 Function(A) fa) =>
      fold((e) => left(fe(e)), (a) => right(fa(a)));
}

/// Extension methods to give Validated operators
extension ValidatedSemigroupApplicativeOperator<A> on Validated<A> {
  /// provides Validated with an operator for applicative
  Either<ArgumentError, A> operator &(Either<ArgumentError, A> other) =>
      aps(other.map((a) => id), argumentErrorSi);
}
