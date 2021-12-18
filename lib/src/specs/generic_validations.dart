part of applicative_validation_specs;

/// this function is a prelude to all validations
Validated<A> requiredValue<A>(Field<A> field, A? value) {
  return value != null
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding("required.err", {}),
          ),
        );
}

Validated<String> notEmpty(Field<String> field, String value) {
  return value.trim().isNotEmpty
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding("empty.err", {}),
          ),
        );
}

Validated<String> alphaNumeric(Field<String> field, String value) {
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  return validCharacters.hasMatch(value) || value.isEmpty
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding("alphanumeric.err", {}),
          ),
        );
}

Validated<String> noWhiteSpace(Field<String> field, String value) {
  return !value.contains(" ")
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding("white_space.err", {}),
          ),
        );
}

Validated<String> nonRepeating(Field<String> field, String value) {
  final validCharacters = RegExp(r'^(?:(.)(?!\1\1))+$');
  return validCharacters.hasMatch(value) || value.isEmpty
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding(
              "repeating.err",
              {},
            ),
          ),
        );
}

Validated<String> minLength(Field<String> field, String value, int length) {
  return value.length >= length
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding(
                "minimum_length.err", {"minLength": length.toString()}),
          ),
        );
}

Validated<String> maxLength(Field<String> field, String value, int length) {
  return value.length <= length
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            field.name,
            ErrorArgumentsBinding(
                "maximum_length.err", {"maxLength": length.toString()}),
          ),
        );
}
