import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'form_condition.dart';

enum FailureSeverity { warning, error }

@immutable
abstract class FormPageState
    implements
        FormCondition<FormPageStateSubmissionFailure, FormPageStateSubmission>,
        Equatable {
  const FormPageState();

  @override
  bool? get stringify => false;
}

@immutable
class FormPageStateSubmission extends FormPageState {
  final String username;
  final String password;
  final String newPassword1;
  final String newPassword2;
  final IList<ArgumentError>? formErrors;

  const FormPageStateSubmission(
      {required this.username,
      required this.password,
      required this.newPassword1,
      required this.newPassword2,
      required this.formErrors});

  FormPageStateSubmission pass() => copyWith(formErrors: null);

  FormPageStateSubmission fail(Cons<ArgumentError> errors) =>
      copyWith(formErrors: errors);

  FormPageStateSubmissionFailure error(String failureMessage) {
    return FormPageStateSubmissionFailure(
        username: username,
        password: password,
        newPassword1: newPassword1,
        newPassword2: newPassword2,
        failureMessage: failureMessage,
        failureSeverity: FailureSeverity.error,
        formErrors: null);
  }

  FormPageStateSubmissionFailure warning(String failureMessage) {
    return FormPageStateSubmissionFailure(
        username: username,
        password: password,
        newPassword1: newPassword1,
        newPassword2: newPassword2,
        failureMessage: failureMessage,
        failureSeverity: FailureSeverity.warning,
        formErrors: null);
  }

  @override
  B outcome<B>(B Function(FormPageStateSubmissionFailure failure) failureEffect,
          B Function(FormPageStateSubmission submission) readyEffect) =>
      readyEffect(this);

  @override
  B status<B>(B Function() recoverEffect, B Function() continueEffect) =>
      formErrors == null ? continueEffect() : recoverEffect();

  @override
  List<Object?> get props =>
      [username, password, newPassword1, newPassword2, formErrors];

  FormPageStateSubmission copyWith(
      {bool? submitted,
      String? username,
      String? password,
      String? newPassword1,
      String? newPassword2,
      IList<ArgumentError>? formErrors}) {
    return FormPageStateSubmission(
        username: username ?? this.username,
        password: password ?? this.password,
        newPassword1: newPassword1 ?? this.newPassword1,
        newPassword2: newPassword2 ?? this.newPassword2,
        formErrors: formErrors ?? this.formErrors);
  }
}

@immutable
class FormPageStateSubmissionFailure extends FormPageStateSubmission {
  final String failureMessage;
  final FailureSeverity failureSeverity;

  const FormPageStateSubmissionFailure({
    required String username,
    required String password,
    required String newPassword1,
    required String newPassword2,
    required IList<ArgumentError>? formErrors,
    required this.failureMessage,
    required this.failureSeverity,
  }) : super(
            username: username,
            password: password,
            newPassword1: newPassword1,
            newPassword2: newPassword2,
            formErrors: formErrors);

  @override
  B outcome<B>(B Function(FormPageStateSubmissionFailure failure) failureEffect,
          B Function(FormPageStateSubmission submission) readyEffect) =>
      failureEffect(this);

  @override
  B status<B>(B Function() recoverEffect, B Function() continueEffect) =>
      failureSeverity == FailureSeverity.error
          ? recoverEffect()
          : continueEffect();

  @override
  List<Object?> get props => [
        username,
        password,
        newPassword1,
        newPassword2,
        failureMessage,
        formErrors
      ];
}
