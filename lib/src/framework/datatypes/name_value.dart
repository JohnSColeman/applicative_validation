part of applicative_validation_framework;

class NameValue<A> {
  final String _name;
  final A _value;

  NameValue(this._name, this._value);

  String get name => _name;

  A get value => _value;
}
