part of applicative_validation_framework;

/// Represents a name and value pair.
class NameValue<A> {
  final String _name;
  final A _value;

  NameValue(this._name, this._value);

  /// name
  String get name => _name;

  /// value
  A get value => _value;

  /// creates a copy of this NameValue with the given value
  NameValue of(A value) => NameValue(_name, value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameValue &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _value == other._value;

  @override
  int get hashCode => _name.hashCode ^ _value.hashCode;
}
