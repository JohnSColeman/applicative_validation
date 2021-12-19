part of applicative_validation_framework;

/// Alias an Either with left type ArgumentError to represent a Validated
typedef Validated<A> = Either<ArgumentError, A>;

/// Alias for a function that returns a Validation given a NameValue
typedef Validation<A> = Validated<A> Function(NameValue);