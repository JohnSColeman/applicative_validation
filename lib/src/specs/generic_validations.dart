part of applicative_validation_specs;

Validated<String> Function(NameValue) notEmpty() {
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

Validated<String> Function(NameValue) alphaNumeric() {
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

Validated<String> Function(NameValue) noWhiteSpace() {
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

Validated<String> Function(NameValue) nonRepeating() {
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

Validated<String> Function(NameValue) minLength(int length) {
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

Validated<String> Function(NameValue) maxLength(int length) {
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
