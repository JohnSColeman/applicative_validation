part of applicative_validation_framework;

/// A Semigroup for the ArgumentError type that collects the message values.
class ArgumentErrorSemiGroup extends Semigroup<ArgumentError> {
  @override
  ArgumentError append(ArgumentError a1, ArgumentError a2) =>
      ArgumentError.value(
          a1.invalidValue, a1.name, _combine(a1.message, a2.message));

  dynamic _combine(dynamic message1, dynamic message2) {
    if (message2 is List) {
      return [
        ...message2,
        ...[message1]
      ];
    }
    return [message2, message1];
  }
}

final Semigroup<ArgumentError> argumentErrorSi = ArgumentErrorSemiGroup();