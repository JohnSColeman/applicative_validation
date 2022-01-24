import 'package:applicative_validation/applicative_validation_framework.dart';

import '../update/change_password_request.dart';
import 'validator_specs.dart';
import 'form_validations.dart';

/// Validates a password change
///
/// returns a ValidatedNeil of either ArgumentErrors or a ChangePasswordRequest
ValidatedNeil<ArgumentError, ChangePasswordRequest> validatePasswordChange(
        String username,
        String password,
        String newPassword1,
        String newPassword2) =>
    validate4<String, String, String, String, ChangePasswordRequest>(
        usernameValidator(username),
        passwordValidator(password),
        newPassword1Validator(newPassword1) &
            notEqual(newPassword1Validator.value(newPassword1),
                passwordValidator.value(password)),
        newPassword2Validator(newPassword2) &
            equal(newPassword2Validator.value(newPassword2),
                newPassword1Validator.value(newPassword1)),
        (u, p, p1, p2) => ChangePasswordRequest(
            username: u, password: p, newPassword1: p1, newPassword2: p2));
