part of applicative_validation_render;

/// Encapsulates an errors identifying key value and the associated argument values.
/// A key refers to a unique message string with substitutions for
/// replacement with the named argument values to render a final message string.
class ErrorArgumentsBinding {
  final String _key;
  final Map<String, String> _namedArgs;

  String get key => _key;

  Map<String, String> get namedArgs => _namedArgs;

  ErrorArgumentsBinding(this._key, this._namedArgs);

  @override
  String toString() {
    return 'ErrorArgumentsBinding{_languageKey: $_key, _namedArgs: $_namedArgs}';
  }
}
