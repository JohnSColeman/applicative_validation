part of applicative_validation_framework;

class NameValue<A> {
  final String _name;
  final A _value;

  NameValue(this._name, this._value);

  String get name => _name;

  A get value => _value;

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
