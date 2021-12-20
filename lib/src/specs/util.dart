part of applicative_validation_specs;

bool isCreditCard(String cardNumber) {
  final cleanCardNumber = cardNumber.replaceAll(RegExp(r'[^0-9]+'), '');
  return isLuhn(cleanCardNumber);
}

/// Luhn algorithm check
bool isLuhn(String number) {
  double sum = 0;
  var flag = false;
  for (final digit in number.codeUnits.reversed) {
    double d = digit - 48;
    if (flag) {
      d *= 2;
      if (d > 9) {
        d -= 9;
      }
    }
    sum += d;
    flag = !flag;
  }
  return (sum % 10 == 0);
}