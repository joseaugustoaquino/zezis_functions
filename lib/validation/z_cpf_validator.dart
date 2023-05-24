import 'dart:math';

class ZCpfValidator {
  static const List<String> blackList = [
    "00000000000",
    "11111111111",
    "22222222222",
    "33333333333",
    "44444444444",
    "55555555555",
    "66666666666",
    "77777777777",
    "88888888888",
    "99999999999",
    "12345678909"
  ];

  static const stripRegex = r'[^\d]';

  static int verifyingDigit(String cpf) {
    List<int> numbers =
    cpf.split("").map((number) => int.parse(number, radix: 10)).toList();

    int modulus = numbers.length + 1;

    List<int> multiplied = [];

    for (var i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }

    int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  static String format(String cpf) {
    RegExp regExp = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');

    return strip(cpf).replaceAllMapped(
        regExp, (Match m) => "${m[1]}.${m[2]}.${m[3]}-${m[4]}");
  }

  static String strip(String? cpf) {
    RegExp regExp = RegExp(stripRegex);
    cpf = cpf ?? "";

    return cpf.replaceAll(regExp, "");
  }

  static bool isValid(String? cpf, [stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      cpf = strip(cpf);
    }

    if (cpf == null || cpf.isEmpty) {
      return false;
    }

    if (cpf.length != 11) {
      return false;
    }

    if (blackList.contains(cpf)) {
      return false;
    }

    String numbers = cpf.substring(0, 9);
    numbers += verifyingDigit(numbers).toString();
    numbers += verifyingDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) == cpf.substring(cpf.length - 2);
  }

  static String generate([bool useFormat = false]) {
    String numbers = "";

    for (var i = 0; i < 9; i += 1) {
      numbers += Random().nextInt(9).toString();
    }

    numbers += verifyingDigit(numbers).toString();
    numbers += verifyingDigit(numbers).toString();

    return (useFormat ? format(numbers) : numbers);
  }
}