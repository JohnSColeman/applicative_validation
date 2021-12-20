import 'package:applicative_validation/applicative_validation_render.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

/// creates an error message by joining each errors transformed error value
String? tre<A>(ArgumentError? error) => error
    ?.renderToList((binding) => tr(binding.key, namedArgs: binding.namedArgs))
    .toList()
    .join(", ");

/// creates an error message by joining each errors transformed error value
String? trv<A>(Either<ArgumentError, A?> validated) => validated.fold(
    (error) => error
        .renderToList(
            (binding) => tr(binding.key, namedArgs: binding.namedArgs))
        .toList()
        .join(", "),
    (a) => null);

/// creates an error message using the given key with the collected named args from each error
String? trvk<A>(String key, Either<ArgumentError, A?> validated) => validated
    .fold((error) => tr(key, namedArgs: error.collectNamedArgs()), (a) => null);
