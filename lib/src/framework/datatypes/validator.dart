part of applicative_validation_framework;

/// Encapsulates a validation for a field and the type of its value
///
/// A is the underlying type of the validated data
/// name identifies the associated field - a language key or value for logging
class Validator<A> {
  /// this fields name
  final String name;

  /// true if a null value is valid for this field (value is optional)
  final bool nullable;

  /// a collection of validations to apply to a value for this field
  final Iterable<Validation<A>> validation;

  Validator(
      {required this.name, required this.validation, this.nullable = false});

  /// returns a copy of this field with an alias name
  Validator<A> alias(String alias) =>
      Validator<A>(name: alias, validation: validation, nullable: nullable);

  /// returns a NameValue for this Validator with the given value
  NameValue<A> value(A value) => NameValue(name, value);

  /// returns a validated for this field given field value
  Validated<A> call(A? value) {
    final Validated<A> required = (value != null || nullable)
        ? right(value)
        : left(ArgumentError.value(
            null, name, ErrorArgumentsBinding("required.err", {})));
    return value == null
        ? required
        : required.flatMap((_) => validation
            .map((validator) => validator(NameValue(name, value)))
            .reduce((value, element) => value & element));
  }
}
