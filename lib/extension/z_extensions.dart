
import 'package:intl/intl.dart';

extension CurrencyDouble on double {
  String toCurrency({
    String locale = 'pt_BR',
    String symbol = "R\$",
    int digits = 2,
  }) => NumberFormat.currency(
    locale: locale,
    symbol: symbol,
    decimalDigits: digits
  ).format(this);
}

extension ConvertString on String {
  double toCurrencyNumeric() {
    try {
      if (isNullOrEmpty()) { return 0.0; }

      var numeric = double.parse(replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", "."));
      return numeric;
    } catch (_) {
      throw ArgumentError("the entered value is invalid: $this");
    }
  }

  double toDecimal() {
    try {
      if (isNullOrEmpty()) { return 0.0; }

      var numeric = double.parse(this);
      return numeric;
    } catch (_) {
      throw ArgumentError("the entered value is invalid: $this");
    }
  }

  int toInt() {
    try {
      if (isNullOrEmpty()) { return 0; }

      var numeric = int.parse(this);
      return numeric;
    } catch (_) {
      throw ArgumentError("the entered value is invalid: $this");
    }
  }

  bool toBool() {
    try {
      if (isNullOrEmpty()) { return false; }

      if (toUpperCase() == 'TRUE') { return true; }
      if (toUpperCase() == 'T')    { return true; }
      if (this == '1')             { return true; }

      if (toUpperCase() == 'FALSE') { return false; }
      if (toUpperCase() == 'F')     { return false; }
      if (this == '0')              { return false; }

      return false;
    } catch (_) {
      throw ArgumentError("the entered value is invalid: $this");
    }
  }

  String formatMask({required String mask}) {
    var value = this;

    if (value.isNullOrEmpty()) { return ""; }
    mask = mask.replaceAll("0", "#");

    // Remove qualquer caractere que não seja numérico
    value = value.replaceAll(RegExp(r'[^\d]'), '');
    
    // Se o número for menor que a máscara, retorna apenas o número
    if (value.length < mask.replaceAll(RegExp(r'[^\#]'), '').length) { return value; }
    
    int index = 0;
    String maskedNumber = '';
    
    // Percorre cada caractere da máscara
    for (int i = 0; i < mask.length; i++) {
      if (mask[i] == '#') {
        // Se o caractere for um '#', adiciona o próximo dígito do número
        maskedNumber += value[index];
        index++;
      } else {
        // Se o caractere não for um '#', adiciona o próprio caractere da máscara
        maskedNumber += mask[i];
      }
    }
    
    return maskedNumber;
  }

  String toCapitalized() {
    try {
      return length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
    } catch (_) {
      throw ArgumentError("the entered value is invalid: $this");
    }
  }

  String toUpperFirstCase() {
    try {
      return replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
    } catch (_) {
      throw ArgumentError("the entered value is invalid: $this");
    }
  }
}

extension ConvertDateTime on DateTime {
  String toMonthDescription() {
    switch (month) {
      case 1: return "Janeiro";
      case 2: return "Fevereiro";
      case 3: return "Março";
      case 4: return "Abril";
      case 5: return "Maio";
      case 6: return "Junho";
      case 7: return "Julho";
      case 8: return "Agosto";
      case 9: return "Setembro";
      case 10: return "Outubro";
      case 11: return "Novembro";
      case 12: return "Dezembro";
      
      default: return "Not Found";
    }
  }

  String toDayWeek() {
    switch (weekday) {
      case 1: return "Segunda";
      case 2: return "Terça";
      case 3: return "Quarta";
      case 4: return "Quinta";
      case 5: return "Sexta";
      case 6: return "Sábado";
      case 7: return "Domingo";

      default: return "Not Found";
    }
  }

  int lastDay() {
    switch (month) {
      case 1: return 31;
      case 2: return 28;
      case 3: return 31;
      case 4: return 30;
      case 5: return 31;
      case 6: return 30;
      case 7: return 31;
      case 8: return 31;
      case 9: return 30;
      case 10: return 31;
      case 11: return 30;
      case 12: return 31;

      default: return 30;
    }
  }

  List<DateTime> generateWeek() {
    DateTime start = this;

    switch (weekday) {
      case 1: start = add(const Duration(days: -1)); break;
      case 2: start = add(const Duration(days: -2)); break;
      case 3: start = add(const Duration(days: -3)); break;
      case 4: start = add(const Duration(days: -4)); break;
      case 5: start = add(const Duration(days: -5)); break;
      case 6: start = add(const Duration(days: -6)); break;
    }

    return [
      start.add(const Duration(days: 0)), // Sunday
      start.add(const Duration(days: 1)), // Monday
      start.add(const Duration(days: 2)), // Tuesday
      start.add(const Duration(days: 3)), // Fourth
      start.add(const Duration(days: 4)), // Fifth
      start.add(const Duration(days: 5)), // Friday
      start.add(const Duration(days: 6)), // Saturday
    ];
  }
}

extension ValidationDynamic<T> on T {
  bool isNullOrEmpty() {
    if (this == null) { return true; }
    if (runtimeType == List) { return (this as List).isEmpty; }
    if (runtimeType == String) { return (this as String).trim().isEmpty; }

    return false;
  }
}

extension ListConvert<T> on List<T> {
  double sumBy(num Function(T element) f) {
    var sum = 0.0;

    for (var i in this) {
      sum += f(i);
    }
    
    return sum;
  }
}