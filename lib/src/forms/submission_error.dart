part of applicative_validation_forms;

/// Error thrown when a form submission fails.
class SubmissionError extends Error {
  /// Message describing the submission error.
  final Object? message;

  /// The underlying source of this error.
  final Error? error;

  /// Creates a submission error with the provided [message].
  SubmissionError(this.message, [this.error]);

  @override
  String toString() {
    if (message != null) {
      return "Submission failed: ${Error.safeToString(message)}";
    }
    return "Submission failed";
  }
}