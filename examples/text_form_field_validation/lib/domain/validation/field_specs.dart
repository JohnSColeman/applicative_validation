import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_specs.dart';

Validated<String> passwordValidation(Field<String> field, String value) =>
    minLength(field, value, 8) &
    maxLength(field, value, 12) &
    noWhiteSpace(field, value) &
    nonRepeating(field, value);

final usernameField = Field<String>(
    name: "username",
    validation: (Field<String> field, String value) =>
        minLength(field, value, 8) &
        maxLength(field, value, 15) &
        noWhiteSpace(field, value) &
        alphaNumeric(field, value));

final passwordField = Field<String>(
    name: "password",
    validation: (Field<String> field, String value) =>
        passwordValidation(field, value));
