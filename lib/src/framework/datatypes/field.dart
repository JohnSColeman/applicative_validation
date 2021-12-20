part of applicative_validation_framework;

/// Encapsulates the properties of a field and the type of its value
///
/// A is the underlying type of the validated data
/// name identifies the field - could be a language key or value for logging
class Field<A> {
  final String _name;

  final bool _nullable;

  /// this fields validations
  final Iterable<Validation<A>> _validation;

  /// this fields name
  String get name => _name;

  /// true of this fields value is nullable (not required)
  bool get nullable => _nullable;

  Field({required name, required validation, required nullable})
      : _name = name,
        _validation = validation,
        _nullable = nullable;

  /// create a copy of this field with an alias name
  Field<A> alias(String alias) =>
      Field<A>(name: alias, validation: _validation, nullable: _nullable);

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
