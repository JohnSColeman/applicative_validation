import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_specs.dart';

final usernameField = Field<String>(
    name: "username",
    validation: [minLength(8), maxLength(15), noWhiteSpace(), alphanumeric()]);

final passwordField = Field<String>(
    name: "password",
    validation: [minLength(8), maxLength(12), noWhiteSpace(), nonRepeating()]);

final newPassword1Field = passwordField.alias("newPassword1");

final newPassword2Field = passwordField.alias("newPassword2");
