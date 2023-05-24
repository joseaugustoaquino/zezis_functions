import 'dart:math';

class ZCnpjValidator {
  static const blackList = <String>[
    "11111111111111",
    "22222222222222",
    "33333333333333",
    "44444444444444",
    "55555555555555",
    "66666666666666",
    "77777777777777",
    "88888888888888",
    "99999999999999"
  ];

  static const stripRegex = r'[^\d]';

  static int verifyingDigit(String cnpj) {
    int index = 2;

    List<int> reverse =
        cnpj.split("").map((s) => int.parse(s)).toList().reversed.toList();

    int sum = 0;

    for (var number in reverse) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    }

    int mod = sum % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  static String format(String cnpj) {
    RegExp regExp = RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$');

    return strip(cnpj).replaceAllMapped(
        regExp, (Match m) => "${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}");
  }

  static String strip(String? cnpj) {
    RegExp regex = RegExp(stripRegex);
    cnpj = cnpj ?? "";

    return cnpj.replaceAll(regex, "");
  }

  static bool isValid(String? cnpj, [stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      cnpj = strip(cnpj);
    }

    if (cnpj == null || cnpj.isEmpty) {
      return false;
    }

    if (cnpj.length != 14) {
      return false;
    }

    if (blackList.contains(cnpj)) {
      return false;
    }

    String numbers = cnpj.substring(0, 12);
    numbers += verifyingDigit(numbers).toString();
    numbers += verifyingDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) == cnpj.substring(cnpj.length - 2);
  }

  static String generate([bool useFormat = false]) {
    String numbers = "";

    for (var i = 0; i < 12; i += 1) {
      numbers += Random().nextInt(9).toString();
    }

    numbers += verifyingDigit(numbers).toString();
    numbers += verifyingDigit(numbers).toString();

    return (useFormat ? format(numbers) : numbers);
  }
}
