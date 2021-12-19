part of applicative_validation_framework;

/// Alias an Either with left type ArgumentError to represent a Validated
typedef Validated<A> = Either<ArgumentError, A>;
