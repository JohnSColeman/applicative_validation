part of applicative_validation_framework;

/// Encapsulates the properties of a field and the type of its value
///
/// A is the underlying type of the validated data
/// name identifies the field - could be a language key or value for logging
class Field<A> {
  final String _name;

  /// this fields validations
  final Iterable<Validation<A>> _validation;

  /// this fields name
  String get name => _name;

  Field({required name, required validation})
      : _name = name,
        _validation = validation;

  /// create a copy of this field with an alias name
  Field<A> alias(String alias) =>
      Field<A>(name: alias, validation: _validation);

  /// returns a validated for the given field value
  Validated<A> call(A? value) {
    final Validated<A> required = value != null
        ? right(value)
        : left(ArgumentError.value(
            null, name, ErrorArgumentsBinding("required.err", {})));
    return required.flatMap((valid) => _validation
        .map((e) => e(NameValue(_name, valid)))
        .reduce((value, element) => value & element));
  }
}
