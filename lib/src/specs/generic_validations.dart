part of applicative_validation_specs;

Validation<String> notEmpty() {
  return (NameValue<String> nameValue) => nameValue.value.trim().isNotEmpty
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding("empty.err", {}),
          ),
        );
}

Validation<String> alpha() {
  final validCharacters = RegExp(r'^[a-zA-Z]+$');
  return (NameValue<String> nameValue) =>
      validCharacters.hasMatch(nameValue.value)
          ? right(nameValue.value)
          : left(
              ArgumentError.value(
                nameValue.value,
                nameValue.name,
                ErrorArgumentsBinding("alpha.err", {}),
              ),
            );
}

Validation<String> alphanumeric() {
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  return (NameValue<String> nameValue) =>
      validCharacters.hasMatch(nameValue.value)
          ? right(nameValue.value)
          : left(
              ArgumentError.value(
                nameValue.value,
                nameValue.name,
                ErrorArgumentsBinding("alphanumeric.err", {}),
              ),
            );
}

Validation<String> integer() {
  final validCharacters = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
  return (NameValue<String> nameValue) =>
      validCharacters.hasMatch(nameValue.value)
          ? right(nameValue.value)
          : left(
              ArgumentError.value(
                nameValue.value,
                nameValue.name,
                ErrorArgumentsBinding("integer.err", {}),
              ),
            );
}

Validation<String> creditCard() {
  return (NameValue<String> nameValue) => isCreditCard(nameValue.value)
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding("credit_card.err", {}),
          ),
        );
}

Validation<String> email() {
  final validEmail = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return (NameValue<String> nameValue) => validEmail.hasMatch(nameValue.value)
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding("email.err", {}),
          ),
        );
}

Validation<String> noWhiteSpace() {
  return (NameValue<String> nameValue) => !nameValue.value.contains(" ")
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
  return (NameValue<String> nameValue) =>
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
  return (NameValue<String> nameValue) => nameValue.value.length >= length
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
  return (NameValue<String> nameValue) => nameValue.value.length <= length
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

Validation<String> equalLength(int length) {
  return (NameValue<String> nameValue) => nameValue.value.length == length
      ? right(nameValue.value)
      : left(
          ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding(
                "equal_length.err", {"equalLength": length.toString()}),
          ),
        );
}
