part of applicative_validation_framework;

/// Abstract type with a name property.
abstract class Named {
  final String _name;

  Named(this._name);

  /// name
  String get name => _name;
}

/// Encapsulates a name and value pair.
class NameValue<A> extends Named {
  final A _value;

  NameValue(String name, this._value): super(name);

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


  /// Validates that this name value and the other name value are equal
  Validated<A> equal(NameValue<A> other) {
    return value == other.value
        ? right(value)
        : left(
      ArgumentError.value(
        value,
        name,
        ErrorArgumentsBinding("equal.err", {
          "name1": name,
          "value1": value.toString(),
          "name2": other.name,
          "value2": other.value.toString()
        }),
      ),
    );
  }

  /// Validates that this name value and the other name value are not equal
  Validated<A> notEqual(NameValue<A> other) {
    return value != other.value
        ? right(value)
        : left(
      ArgumentError.value(
        value,
        name,
        ErrorArgumentsBinding("not_equal.err", {
          "name1": name,
          "value1": value.toString(),
          "name2": other.name,
          "value2": other.value.toString()
        }),
      ),
    );
  }
}
