part of applicative_validation_framework;

/// non-empty immutable list
typedef Neil<A> = Cons<A>;

typedef ValidatedNeil<E, A> = Either<Neil<E>, A>;

const Either<ArgumentError, Unit> validUnit = Right(unit);

/// Helper methods for combining a number of different validations.
///
/// Argument errors are accumulated for the left inputs otherwise the results
/// of the right inputs are applied to the z function to yield a Z.
ValidatedNeil<ArgumentError, Z> validate2<A, B, Z>(
        Validated<A> a, Validated<B> b, Z Function(A, B) z) =>
    _apply(
        a,
        b,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        (A a, B b, _, __, ___, ____, _____, ______, _______, _________) =>
            z(a, b));

ValidatedNeil<ArgumentError, Z> validate3<A, B, C, Z>(Validated<A> a,
        Validated<B> b, Validated<C> c, Z Function(A, B, C) z) =>
    _apply(
        a,
        b,
        c,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        (A a, B b, C c, __, ___, ____, _____, ______, _______, _________) =>
            z(a, b, c));

ValidatedNeil<ArgumentError, Z> validate4<A, B, C, D, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Z Function(A, B, C, D) z) =>
    _apply(
        a,
        b,
        c,
        d,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        (A a, B b, C c, D d, ___, ____, _____, ______, _______, _________) =>
            z(a, b, c, d));

ValidatedNeil<ArgumentError, Z> validate5<A, B, C, D, E, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Validated<E> e,
        Z Function(A, B, C, D, E) z) =>
    _apply(
        a,
        b,
        c,
        d,
        e,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        (A a, B b, C c, D d, E e, ____, _____, ______, _______, _________) =>
            z(a, b, c, d, e));

ValidatedNeil<ArgumentError, Z> validate6<A, B, C, D, E, F, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Validated<E> e,
        Validated<F> f,
        Z Function(A, B, C, D, E, F) z) =>
    _apply(
        a,
        b,
        c,
        d,
        e,
        f,
        validUnit,
        validUnit,
        validUnit,
        validUnit,
        (A a, B b, C c, D d, E e, F f, _____, ______, _______, _________) =>
            z(a, b, c, d, e, f));

ValidatedNeil<ArgumentError, Z> validate7<A, B, C, D, E, F, G, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Validated<E> e,
        Validated<F> f,
        Validated<G> g,
        Z Function(A, B, C, D, E, F, G) z) =>
    _apply(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        validUnit,
        validUnit,
        validUnit,
        (A a, B b, C c, D d, E e, F f, G g, ______, _______, _________) =>
            z(a, b, c, d, e, f, g));

ValidatedNeil<ArgumentError, Z> validate8<A, B, C, D, E, F, G, H, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Validated<E> e,
        Validated<F> f,
        Validated<G> g,
        Validated<H> h,
        Z Function(A, B, C, D, E, F, G, H) z) =>
    _apply(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h,
        validUnit,
        validUnit,
        (A a, B b, C c, D d, E e, F f, G g, H h, _______, _________) =>
            z(a, b, c, d, e, f, g, h));

ValidatedNeil<ArgumentError, Z> validate9<A, B, C, D, E, F, G, H, I, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Validated<E> e,
        Validated<F> f,
        Validated<G> g,
        Validated<H> h,
        Validated<I> i,
        Z Function(A, B, C, D, E, F, G, H, I) z) =>
    _apply(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h,
        i,
        validUnit,
        (A a, B b, C c, D d, E e, F f, G g, H h, I i, _________) =>
            z(a, b, c, d, e, f, g, h, i));

ValidatedNeil<ArgumentError, Z> validate10<A, B, C, D, E, F, G, H, I, J, Z>(
        Validated<A> a,
        Validated<B> b,
        Validated<C> c,
        Validated<D> d,
        Validated<E> e,
        Validated<F> f,
        Validated<G> g,
        Validated<H> h,
        Validated<I> i,
        Validated<J> j,
        Z Function(A, B, C, D, E, F, G, H, I, J) z) =>
    _apply(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h,
        i,
        j,
        (A a, B b, C c, D d, E e, F f, G g, H h, I i, J j) =>
            z(a, b, c, d, e, f, g, h, i, j));

ValidatedNeil<ArgumentError, Z> _apply<A, B, C, D, E, F, G, H, I, J, Z>(
    Validated<A> a,
    Validated<B> b,
    Validated<C> c,
    Validated<D> d,
    Validated<E> e,
    Validated<F> f,
    Validated<G> g,
    Validated<H> h,
    Validated<I> i,
    Validated<J> j,
    Z Function(A, B, C, D, E, F, G, H, I, J) z) {
  Neil<ArgumentError>? combineInvalidValues<_>(
      Neil<ArgumentError>? accumulatedError, Validated<_> validated) {
    if (validated.isLeft()) {
      return accumulatedError == null
          ? Cons<ArgumentError>((validated as Left).value, nil())
          : accumulatedError
              .appendElement((validated as Left).value)
              .asCons()
              .toNullable();
    }
    return accumulatedError;
  }

  if (a.isRight() &&
      b.isRight() &&
      c.isRight() &&
      d.isRight() &&
      e.isRight() &&
      f.isRight() &&
      g.isRight() &&
      h.isRight() &&
      i.isRight() &&
      j.isRight()) {
    return right(z(
        (a as Right).value,
        (b as Right).value,
        (c as Right).value,
        (d as Right).value,
        (e as Right).value,
        (f as Right).value,
        (g as Right).value,
        (h as Right).value,
        (i as Right).value,
        (j as Right).value));
  } else {
    // unsafe
    Neil<ArgumentError>? argumentErrors;
    argumentErrors = combineInvalidValues(argumentErrors, a);
    argumentErrors = combineInvalidValues(argumentErrors, b);
    argumentErrors = combineInvalidValues(argumentErrors, c);
    argumentErrors = combineInvalidValues(argumentErrors, d);
    argumentErrors = combineInvalidValues(argumentErrors, e);
    argumentErrors = combineInvalidValues(argumentErrors, f);
    argumentErrors = combineInvalidValues(argumentErrors, g);
    argumentErrors = combineInvalidValues(argumentErrors, h);
    argumentErrors = combineInvalidValues(argumentErrors, i);
    argumentErrors = combineInvalidValues(argumentErrors, j);
    return left(argumentErrors!);
  }
}
