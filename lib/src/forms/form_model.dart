part of applicative_validation_forms;

/// Enumerates the different stats of a form.
enum FormStatus { clear, invalid, warning, failure, success }

/// Implements the generic behaviours of a form associated with the form type F
@immutable
class FormModel<F extends Equatable> implements FormCondition<F>, Equatable {
  final F form;
  final FormStatus status;
  final List<Error> errors;

  const FormModel(this.form, this.status, this.errors);

  FormModel.withState(this.form)
      : status = FormStatus.clear,
        errors = [];

  /// transitions a form into the readied state
  FormModel<F> ready() => FormModel(form, FormStatus.clear, const []);

  /// transitions a form into the invalidated state with the given argument errors
  FormModel<F> invalidate(List<ArgumentError> errors) =>
      FormModel(form, FormStatus.invalid, this.errors + errors);

  /// transitions the form into the warned state with the given submission errors
  FormModel<F> warn(List<SubmissionError> errors) =>
      FormModel(form, FormStatus.warning, this.errors + errors);

  /// transitions the form into the failed state with the given submission errors
  FormModel<F> fail(List<SubmissionError> errors) =>
      FormModel(form, FormStatus.failure, this.errors + errors);

  @override
  B readied<B>(B Function(F form) readyEffect,
          B Function(F, Iterable<Error>) otherEffect) =>
      (status == FormStatus.clear || status == FormStatus.success)
          ? readyEffect(form)
          : otherEffect(form, errors);

  @override
  B invalidated<B>(B Function(Iterable<ArgumentError>) invalidEffect,
          B Function() otherEffect) =>
      (status == FormStatus.invalid)
          ? invalidEffect(_argumentErrors)
          : otherEffect();

  @override
  B failed<B>(B Function(Iterable<SubmissionError> p1) failureEffect,
      B Function() otherEffect) {
    return (status == FormStatus.failure)
        ? failureEffect(_submissionErrors)
        : otherEffect();
  }

  @override
  B warned<B>(B Function(Iterable<SubmissionError>) warningEffect,
          B Function() otherEffect) =>
      (status == FormStatus.warning)
          ? warningEffect(_submissionErrors)
          : otherEffect();

  Iterable<ArgumentError> get _argumentErrors =>
      errors.whereType<ArgumentError>();

  Iterable<SubmissionError> get _submissionErrors =>
      errors.whereType<SubmissionError>();

  @override
  List<Object?> get props => form.props + [status, errors];

  @override
  bool? get stringify => form.stringify;
}

/// Syntactic sugar to instantiate a FormModel with the given form of type F.
FormModel<F> formModel<F extends Equatable>(F form) =>
    FormModel.withState(form);


