part of applicative_validation_forms;

/// A mixin providing form submission control with validate, reject or process submission implementations.
///
/// type Z is the type of the validation outcome for the form submission
mixin FormSubmission<Z> {
  /// returns the validated result of the function that validates a form submission
  ValidatedNeil<ArgumentError, Z> validateSubmission();

  /// a function to handle the argument errors from an invalided form submission
  void rejectSubmission(Cons<ArgumentError> errors);

  /// a function to process the result of type Z of a validated form submission
  Future<void> processSubmission(Z submission);

  /// a function to validate a submission then call reject submission or process submission
  Future<void> submitForm() async {
    validateSubmission()
        .leftMap<void>((errors) => rejectSubmission(errors))
        .map<void>((z) => processSubmission(z!));
  }
}
