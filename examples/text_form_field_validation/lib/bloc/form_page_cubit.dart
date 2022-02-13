import 'package:applicative_validation/applicative_validation_forms.dart';
import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_form_field_validation/domain/update/change_password_request.dart';
import 'package:text_form_field_validation/domain/validation/form_specs.dart';
import 'package:text_form_field_validation/repository/user_repository.dart';

import 'form_page_state.dart';

class FormPageCubit extends Cubit<FormModel<FormPageState>>
    with FormSubmission<ChangePasswordRequest> {
  static FormPageState initState = const FormPageState(
      username: "", password: "", newPassword1: "", newPassword2: "");

  final UserRepository _userRepository;

  FormPageCubit(this._userRepository) : super(formModel(initState));

  void changeUsername(String username) => state.readied(
      (form) => emit(formModel(form.copyWith(username: username))),
      (form, errors) =>
          emit(formModel(initState.copyWith(username: username))));

  void changePassword(String password) => state.readied(
      (form) => emit(formModel(form.copyWith(password: password))),
      (form, errors) =>
          emit(formModel(initState.copyWith(password: password))));

  void changePassword1(String password) => state.readied(
      (form) => emit(formModel(form.copyWith(newPassword1: password))),
      (form, errors) =>
          emit(formModel(initState.copyWith(newPassword1: password))));

  void changePassword2(String password) => state.readied(
      (form) => emit(formModel(form.copyWith(newPassword2: password))),
      (form, errors) =>
          emit(formModel(initState.copyWith(newPassword2: password))));

  @override
  ValidatedNeil<ArgumentError, ChangePasswordRequest?> validateSubmission() =>
      validatePasswordChange(state.form.username, state.form.password,
          state.form.newPassword1, state.form.newPassword2);

  @override
  void rejectSubmission(Cons<ArgumentError> errors) =>
      emit(state.invalidate(errors.toList()));

  @override
  Future<void> processSubmission(ChangePasswordRequest submission) async {
    final response = await _userRepository.verifyCredential(
        submission.username, submission.password);
    response.fold<void>(
        (ioError) => emit(state.fail(_submitError("io_error.err"))),
        (ioResponse) => ioResponse.fold<void>(
              (endpointWarning) =>
                  emit(state.warn(_submitError("user_not_found.err"))),
              (isUserAuthorized) => isUserAuthorized
                  ? emit(state.ready())
                  : emit(state.warn(_submitError("user_invalid.err"))),
            ));
  }

  List<SubmissionError> _submitError(String key) => [SubmissionError(key)];
}
