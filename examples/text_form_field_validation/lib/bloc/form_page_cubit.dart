import 'package:applicative_validation/applicative_validation_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_form_field_validation/domain/validation/form_specs.dart';
import 'package:text_form_field_validation/repository/user_repository.dart';

import 'form_page_state.dart';

class FormPageCubit extends Cubit<FormModel<FormPageState>> {
  static FormPageState clearSubmission = const FormPageState(
      username: "", password: "", newPassword1: "", newPassword2: "");

  final UserRepository _userRepository;

  FormPageCubit(this._userRepository) : super(formModel(clearSubmission));

  void changeUsername(String username) => state.readied(
      (form) => emit(formModel(form.copyWith(username: username))),
      (form, errors) =>
          emit(formModel(clearSubmission.copyWith(username: username))));

  void changePassword(String password) => state.readied(
      (form) => emit(formModel(form.copyWith(password: password))),
      (form, errors) =>
          emit(formModel(clearSubmission.copyWith(password: password))));

  void changePassword1(String password) => state.readied(
      (form) => emit(formModel(form.copyWith(newPassword1: password))),
      (form, errors) =>
          emit(formModel(clearSubmission.copyWith(newPassword1: password))));

  void changePassword2(String password) => state.readied(
      (form) => emit(formModel(form.copyWith(newPassword2: password))),
      (form, errors) =>
          emit(formModel(clearSubmission.copyWith(newPassword2: password))));

  Future submitForm() async {
    state.readied((submission) {
      validatePasswordChange(submission.username, submission.password,
              submission.newPassword1, submission.newPassword2)
          .leftMap((errors) => emit(state.invalidate(errors.toList())))
          .map<void>((changePasswordRequest) async {
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
      });
    }, (form, errors) => null);
  }

  List<SubmissionError> _submitError(String key) => [SubmissionError(key)];
}
