import 'package:applicative_validation/applicative_validation_framework.dart';

import '../update/change_password_request.dart';
import 'field_specs.dart';
import 'form_validations.dart';

ValidatedNeil<ArgumentError, ChangePasswordRequest> validatePasswordChange(
        String username,
        String password,
        String newPassword1,
        String newPassword2) =>
    validate4<String, String, String, String, ChangePasswordRequest>(
        usernameField.validate(username),
        passwordField.validate(password),
        newPassword1Field.validate(newPassword1) &
            notMatch2("newPassword1", "password", newPassword1, password),
        newPassword2Field.validate(newPassword2) &
            match2("newPassword2", "newPassword1", newPassword2, newPassword1),
        (u, p, p1, p2) => ChangePasswordRequest(
            username: u, password: p, newPassword1: p1, newPassword2: p2));
