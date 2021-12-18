part of applicative_validation_framework;

/// Encapsulates the properties of a field and domain of its value,
/// where A is the underlying type of the validated data and name identifies
/// the field - could be a language key or value for logging.
class Field<A> {
  final String _name;
  final Validated<A> Function(Field<A>, A) _validation;

  String get name => _name;

  Field({required name, required validation})
      : _name = name,
        _validation = validation;

  /// returns a validated for the given field value
  Validated<A> validate(A? value) => requiredValue(this, value)
      .flatMap((valid) => _validation(this, valid));
}
