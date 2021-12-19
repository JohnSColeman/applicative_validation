part of applicative_validation_specs;

Validated<String> notEmpty(String fieldName, String value) {
  return value.trim().isNotEmpty
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            fieldName,
            ErrorArgumentsBinding("empty.err", {}),
          ),
        );
}

Validated<String> alphaNumeric(String fieldName, String value) {
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  return validCharacters.hasMatch(value) || value.isEmpty
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            fieldName,
            ErrorArgumentsBinding("alphanumeric.err", {}),
          ),
        );
}

Validated<String> noWhiteSpace(String fieldName, String value) {
  return !value.contains(" ")
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            fieldName,
            ErrorArgumentsBinding("white_space.err", {}),
          ),
        );
}

Validated<String> nonRepeating(String fieldName, String value) {
  final validCharacters = RegExp(r'^(?:(.)(?!\1\1))+$');
  return validCharacters.hasMatch(value) || value.isEmpty
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            fieldName,
            ErrorArgumentsBinding(
              "repeating.err",
              {},
            ),
          ),
        );
}

Validated<String> minLength(String fieldName, String value, int length) {
  return value.length >= length
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            fieldName,
            ErrorArgumentsBinding(
                "minimum_length.err", {"minLength": length.toString()}),
          ),
        );
}

Validated<String> maxLength(String fieldName, String value, int length) {
  return value.length <= length
      ? right(value)
      : left(
          ArgumentError.value(
            value,
            fieldName,
            ErrorArgumentsBinding(
                "maximum_length.err", {"maxLength": length.toString()}),
          ),
        );
}
