import 'package:applicative_validation/applicative_validation_specs.dart';
import 'package:test/test.dart';

/// test the algos
void main() {
  test("given valid credit card number then is credit card method returns true",
      () {
    expect(isCreditCard("4619183033743468"), true, reason: "4619183033743468 is a valid number");
    expect(isCreditCard("4485566800176931"), true, reason: "4485566800176931 is a valid number");
    expect(isCreditCard("4929481095632495"), true, reason: "4929481095632495 is a valid number");
  });

  test(
      "given invalid credit card number then is credit card method returns false",
      () {
    expect(isCreditCard("1234"), false, reason: "1234 test");
    expect(isCreditCard("8379570101817349"), false, reason: "8379570101817349 test");
    expect(isCreditCard(""), false, reason: "empty test");
  });
}
