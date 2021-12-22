part of applicative_validation_framework;

/// Encapsulates a validation for a field and the type of its value
///
/// A is the underlying type of the validated data
/// name identifies the associated field - a language key or value for logging
class Validator<A> {
  final String _name;

  final bool _nullable;

  final Iterable<Validation<A>> _validation;

  /// this fields name
  String get name => _name;

  /// true if this fields value is nullable (not required)
  bool get nullable => _nullable;

  Validator({required name, required validation, required nullable})
      : _name = name,
        _validation = validation,
        _nullable = nullable;

  /// returns a copy of this field with an alias name
  Validator<A> alias(String alias) =>
      Validator<A>(name: alias, validation: _validation, nullable: _nullable);

  /// returns a NameValue for this Validator with the given value
  NameValue<A> value(A value) => NameValue(name, value);

  /// returns a validated for this field given field value
  Validated<A> call(A? value) {
    final Validated<A> required = (value != null || _nullable)
        ? right(value)
        : left(ArgumentError.value(
            null, name, ErrorArgumentsBinding("required.err", {})));
    return value == null
        ? required
        : required.flatMap((_) => _validation
            .map((validator) => validator(NameValue(_name, value)))
            .reduce((value, element) => value & element));
  }
}
