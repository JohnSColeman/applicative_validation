import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_render.dart';
import 'package:dartz/dartz.dart';

Validated<String> match2(
    String name1, String name2, String value1, String value2) {
  return value1 == value2
      ? right(value1)
      : left(
          ArgumentError.value(
            value1,
            name1,
            ErrorArgumentsBinding("match2.err", {
              "name1": name1,
              "value1": value1,
              "name2": name2,
              "value2": value2
            }),
          ),
        );
}

Validated<A> notMatch2<A>(
    String name1, String name2, A value1, A value2) {
  return value1 != value2
      ? right(value1)
      : left(
          ArgumentError.value(
            value1,
            name1,
            ErrorArgumentsBinding("not_match2.err", {
              "name1": name1,
              "value1": value1.toString(),
              "name2": name2,
              "value2": value2.toString()
            }),
          ),
        );
}
