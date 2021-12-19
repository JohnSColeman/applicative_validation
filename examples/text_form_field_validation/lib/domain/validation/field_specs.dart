import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_specs.dart';

final usernameField = Field<String>(
    name: "username",
    validation: (String fieldName, String value) =>
        minLength(fieldName, value, 8) &
        maxLength(fieldName, value, 15) &
        noWhiteSpace(fieldName, value) &
        alphaNumeric(fieldName, value));

final passwordField = Field<String>(
    name: "password",
    validation: (String fieldName, String value) =>
        minLength(fieldName, value, 8) &
        maxLength(fieldName, value, 12) &
        noWhiteSpace(fieldName, value) &
        nonRepeating(fieldName, value));

final newPassword1Field = passwordField.alias("newPassword1");

final newPassword2Field = passwordField.alias("newPassword2");
