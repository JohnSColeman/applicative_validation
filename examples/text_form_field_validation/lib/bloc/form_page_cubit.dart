import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_form_field_validation/domain/validation/form_specs.dart';
import 'package:text_form_field_validation/repository/user_repository.dart';
import 'form_page_state.dart';

class FormPageCubit extends Cubit<FormPageState> {
  static const cleanSubmission = FormPageStateSubmission(
      submitted: false,
      username: "",
      password: "",
      newPassword1: "",
      newPassword2: "",
      errors: null);

  final UserRepository _userRepository;

  FormPageCubit(this._userRepository) : super(cleanSubmission);

  void changeUsername(String username) => state.outcome(
      (failure) => emit(cleanSubmission.copyWith(username: username)),
      (submission) => emit(submission.copyWith(username: username)));

  void changePassword(String password) => state.outcome(
      (failure) => emit(cleanSubmission.copyWith(password: password)),
      (submission) => emit(submission.copyWith(password: password)));

  void changePassword1(String password) => state.outcome(
      (failure) => emit(cleanSubmission.copyWith(newPassword1: password)),
      (submission) => emit(submission.copyWith(newPassword1: password)));

  void changePassword2(String password) => state.outcome(
      (failure) => emit(cleanSubmission.copyWith(newPassword2: password)),
      (submission) => emit(submission.copyWith(newPassword2: password)));

  Future submitForm() async {
    print("validate");
    state.outcome((failure) => {}, (submission) {
      validatePasswordChange(submission.username, submission.password,
              submission.newPassword1, submission.newPassword2)
          .leftMap((errors) => emit(submission.fail(errors)))
          .map<void>((changePasswordRequest) async {
        final response = await _userRepository.verifyCredential(
            submission.username, submission.password);
        print(response);
        response.fold<void>(
            (ioError) => emit(submission.error("io_error.err")),
            (ioResponse) => ioResponse.fold<void>(
                  (endpointWarning) =>
                      emit(submission.warning("user_not_found.err")),
                  (isUserAuthorized) => isUserAuthorized
                      ? emit(submission.pass())
                      : emit(submission.warning("user_invalid.err")),
                ));
      });
    });
  }
}
