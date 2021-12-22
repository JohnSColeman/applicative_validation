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
  final bool submitted;
  final String username;
  final String password;
  final String newPassword1;
  final String newPassword2;
  final IList<ArgumentError>? errors;

  const FormPageStateSubmission(
      {required this.submitted,
      required this.username,
      required this.password,
      required this.newPassword1,
      required this.newPassword2,
      required this.errors});

  FormPageStateSubmission pass() => copyWith(submitted: true);

  FormPageStateSubmission fail(Cons<ArgumentError> errors) =>
      copyWith(submitted: false, errors: errors);

  FormPageStateSubmissionFailure error(String failureMessage) {
    return FormPageStateSubmissionFailure(
        username: username,
        password: password,
        newPassword1: newPassword1,
        newPassword2: newPassword2,
        failureMessage: failureMessage,
        failureSeverity: FailureSeverity.error,
        errors: nil<ArgumentError>());
  }

  FormPageStateSubmissionFailure warning(String failureMessage) {
    return FormPageStateSubmissionFailure(
        username: username,
        password: password,
        newPassword1: newPassword1,
        newPassword2: newPassword2,
        failureMessage: failureMessage,
        failureSeverity: FailureSeverity.warning,
        errors: nil<ArgumentError>());
  }

  @override
  B outcome<B>(
          B Function(FormPageStateSubmissionFailure failure) failureEffect,
          B Function(FormPageStateSubmission submission) readyEffect) =>
      readyEffect(this);

  @override
  B status<B>(B Function() recoverEffect, B Function() continueEffect) =>
      submitted ? continueEffect() : recoverEffect();

  @override
  List<Object?> get props =>
      [submitted, username, password, newPassword1, newPassword2, errors];

  FormPageStateSubmission copyWith(
      {bool? submitted,
      String? username,
      String? password,
      String? newPassword1,
      String? newPassword2,
      IList<ArgumentError>? errors}) {
    return FormPageStateSubmission(
        submitted: submitted ?? this.submitted,
        username: username ?? this.username,
        password: password ?? this.password,
        newPassword1: newPassword1 ?? this.newPassword1,
        newPassword2: newPassword2 ?? this.newPassword2,
        errors: errors ?? this.errors);
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
    required IList<ArgumentError> errors,
    required this.failureMessage,
    required this.failureSeverity,
  }) : super(
            submitted: false,
            username: username,
            password: password,
            newPassword1: newPassword1,
            newPassword2: newPassword2,
            errors: errors);

  @override
  B outcome<B>(
          B Function(FormPageStateSubmissionFailure failure) failureEffect,
          B Function(FormPageStateSubmission submission) readyEffect) =>
      failureEffect(this);

  @override
  B status<B>(B Function() recoverEffect, B Function() continueEffect) =>
      failureSeverity == FailureSeverity.error
          ? recoverEffect()
          : continueEffect();

  @override
  List<Object?> get props =>
      [username, password, newPassword1, newPassword2, failureMessage, errors];
}
