import 'package:applicative_validation/applicative_validation_framework.dart';
import 'package:applicative_validation/applicative_validation_render.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

/// test the applicative extensions on Validated
void main() {
  Validation<String> valid() =>
      (NameValue<String> nameValue) => right(nameValue.value);

  Validation<String> invalidA() {
    return (NameValue<String> nameValue) => left(ArgumentError.value(
          nameValue.value,
          nameValue.name,
          ErrorArgumentsBinding("invalidA", {}),
        ));
  }

  Validation<String> invalidB() {
    return (NameValue<String> nameValue) => left(ArgumentError.value(
          nameValue.value,
          nameValue.name,
          ErrorArgumentsBinding("invalidB", {}),
        ));
  }

  test("given a valid & valid then result is a right", () {
    final testValue = NameValue("test1", "value");
    final result = valid()(testValue) & valid()(testValue);
    result.fold(
        (l) => fail("expected a right"),
        (r) =>
            expect(r == testValue.value, true, reason: "value not expected"));
  });

  test(
      "given an invalid & valid then result is a left and has a message of a single ErrorArgumentBinding value",
      () {
    final testValue = NameValue("test1", "value");
    final result = invalidA()(testValue) & valid()(testValue);
    result.fold((l) {
      expect(l.message is ErrorArgumentsBinding && l.message.key == "invalidA",
          true,
          reason: "message binding key not expected");
      expect(l.invalidValue == testValue.value, true,
          reason: "invalid value not expected");
      expect(l.name == testValue.name, true, reason: "name not expected");
    }, (r) => fail("expected a left"));
  });

  test(
      "given a valid & invalid then result is a left and has a message of a single ErrorArgumentBinding value",
      () {
    final testValue = NameValue("test2", "value");
    final result = valid()(testValue) & invalidA()(testValue);
    result.fold((l) {
      expect(l.message is ErrorArgumentsBinding && l.message.key == "invalidA",
          true,
          reason: "message binding key not expected");
      expect(l.invalidValue == testValue.value, true,
          reason: "invalid value not expected");
      expect(l.name == testValue.name, true, reason: "name not expected");
    }, (r) => fail("expected a left"));
  });

  test(
      "given an invalid & invalid then result is a left and has a message with 2 ErrorArgumentBinding values",
      () {
    final testValue = NameValue("test3", "value");
    final result = invalidA()(testValue) & invalidB()(testValue);
    result.fold((l) {
      expect(
          l.message is List &&
              l.message[0].key == "invalidA" &&
              l.message[1].key == "invalidB",
          true,
          reason: "message or binding keys not expected");
      expect(l.invalidValue == testValue.value, true,
          reason: "invalid value not expected");
      expect(l.name == testValue.name, true, reason: "name not expected");
    }, (r) => fail("expected a left"));
  });

  test(
      "given an invalid + invalid then result is a left and has a message of a single ErrorArgumentBinding value",
      () {
    final testValue = NameValue("test4", "value");
    final result = invalidA()(testValue) + invalidB()(testValue);
    result.fold((l) {
      expect(l.message is ErrorArgumentsBinding && l.message.key == "invalidA",
          true,
          reason: "message binding key not expected");
      expect(l.invalidValue == testValue.value, true,
          reason: "invalid value not expected");
      expect(l.name == testValue.name, true, reason: "name not expected");
    }, (r) => fail("expected a left"));
  });

  test(
      "given a valid + invalid + invalid then result is a left and has a message of a single ErrorArgumentBinding value",
      () {
    final testValue = NameValue("test4", "value");
    final result =
        valid()(testValue) + invalidA()(testValue) + invalidB()(testValue);
    result.fold((l) {
      expect(l.message is ErrorArgumentsBinding && l.message.key == "invalidA",
          true,
          reason: "message binding key not expected");
      expect(l.invalidValue == testValue.value, true,
          reason: "invalid value not expected");
      expect(l.name == testValue.name, true, reason: "name not expected");
    }, (r) => fail("expected a left"));
  });
}
