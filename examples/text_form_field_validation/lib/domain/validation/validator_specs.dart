import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_specs.dart';

final usernameValidator = Validator<String>(
    name: "username",
    validation: [minLength(8), maxLength(15), noWhiteSpace(), alphanumeric()]);

final passwordValidator = Validator<String>(
    name: "password",
    validation: [minLength(8), maxLength(12), noWhiteSpace(), nonRepeating()]);

final newPassword1Validator = passwordValidator.alias("newPassword1");

final newPassword2Validator = passwordValidator.alias("newPassword2");

