import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_render.dart';
import 'package:dartz/dartz.dart';

Validated<A> equal<A>(NameValue<A> value1, NameValue<A> value2) {
  return value1.value == value2.value
      ? right(value1.value)
      : left(
          ArgumentError.value(
            value1.value,
            value1.name,
            ErrorArgumentsBinding("match2.err", {
              "name1": value1.name,
              "value1": value1.value.toString(),
              "name2": value2.name,
              "value2": value2.value.toString()
            }),
          ),
        );
}

Validated<A> notEqual<A>(NameValue<A> value1, NameValue<A> value2) {
  return value1.value != value2.value
      ? right(value1.value)
      : left(
          ArgumentError.value(
            value1.value,
            value1.name,
            ErrorArgumentsBinding("not_match2.err", {
              "name1": value1.name,
              "value1": value1.value.toString(),
              "name2": value2.name,
              "value2": value2.value.toString()
            }),
          ),
        );
}
