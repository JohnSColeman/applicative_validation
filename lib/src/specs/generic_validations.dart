part of applicative_validation_specs;

final alphaPattern = RegExp(r'^[a-zA-Z]+$');
final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');
final integerPattern = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
final emailPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
final repeatingPattern = RegExp(r'^(?:(.)(?!\1\1))+$');

Validation<String> notEmpty() {
  return (NameValue<String> nameValue) => nameValue.value.trim().isNotEmpty
      ? right(nameValue.value)
      : left(ArgumentError.value(
          nameValue.value,
          nameValue.name,
          ErrorArgumentsBinding("empty.err", {}),
        ));
}

Validation<String> alpha() {
  return (NameValue<String> nameValue) => alphaPattern.hasMatch(nameValue.value)
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
  return (NameValue<String> nameValue) =>
      alphanumericPattern.hasMatch(nameValue.value)
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
  return (NameValue<String> nameValue) =>
      integerPattern.hasMatch(nameValue.value)
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
  return (NameValue<String> nameValue) => emailPattern.hasMatch(nameValue.value)
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
  return (NameValue<String> nameValue) =>
      repeatingPattern.hasMatch(nameValue.value) || nameValue.value.isEmpty
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
