part of applicative_validation_render;

/// Extends argument error to work with the domain framework.
extension ArgumentErrorRenderer on ArgumentError {
  /// transforms this ArgumentError with ErrorArgumentsBindings values
  /// to an immutable list of Strings for human readability
  IList<String> renderToList(
      String Function(ErrorArgumentsBinding) renderBinding) {
    if (message is List) {
      return IList.from(message as List)
          .map((binding) => renderBinding(binding));
    }
    return IList.from([renderBinding(message as ErrorArgumentsBinding)]);
  }

  /// collects the named args of this ArgumentError with ErrorArgumentsBindings values
  Map<String, String> collectNamedArgs() {
    if (message is List) {
      return (message as List).fold<Map<String, String>>(
          <String, String>{},
          (previousValue, binding) => {...previousValue, ...binding.namedArgs});
    }
    return (message as ErrorArgumentsBinding).namedArgs;
  }
}

/// Render argument errors of the given validated Non-empty immutable list
/// using the given render binding function. Use for rendering outputs from an
/// applicative domain validate.
Either<List<String>, Z> renderValidatedNeil<Z>(
        ValidatedNeil<ArgumentError, Z> validatedNeil,
        String Function(ErrorArgumentsBinding) renderBinding) =>
    validatedNeil.bimap(
        (errors) => errors
            .map((error) =>
                error.renderToList((binding) => renderBinding(binding)))
            .flatMap(id)
            .toList(),
        id);
