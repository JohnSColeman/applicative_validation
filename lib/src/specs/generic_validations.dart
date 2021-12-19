part of applicative_validation_specs;

Validation<String> notEmpty() {
  return (NameValue nameValue) => nameValue.value.trim().isNotEmpty
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding("empty.err", {}),
          ),
        );
}

Validation<String> alphaNumeric() {
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  return (NameValue nameValue) =>
      validCharacters.hasMatch(nameValue.value) || nameValue.value.isEmpty
          ? right(nameValue.value)
          : left(
              ArgumentError.value(
                nameValue.value,
                nameValue.name,
                ErrorArgumentsBinding("alphanumeric.err", {}),
              ),
            );
}

Validation<String> noWhiteSpace() {
  return (NameValue nameValue) => !nameValue.value.contains(" ")
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding("white_space.err", {}),
          ),
        );
}

Validation<String> nonRepeating() {
  final validCharacters = RegExp(r'^(?:(.)(?!\1\1))+$');
  return (NameValue nameValue) =>
      validCharacters.hasMatch(nameValue.value) || nameValue.value.isEmpty
          ? right(nameValue.value)
          : left(
              ArgumentError.value(
                nameValue.value,
                nameValue.name,
                ErrorArgumentsBinding(
                  "repeating.err",
                  {},
                ),
              ),
            );
}

Validation<String> minLength(int length) {
  return (NameValue nameValue) => nameValue.value.length >= length
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding(
                "minimum_length.err", {"minLength": length.toString()}),
          ),
        );
}

Validation<String> maxLength(int length) {
  return (NameValue nameValue) => nameValue.value.length <= length
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding(
                "maximum_length.err", {"maxLength": length.toString()}),
          ),
        );
}
