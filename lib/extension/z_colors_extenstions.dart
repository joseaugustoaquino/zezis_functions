
import 'package:flutter/material.dart';

Color hexToColor(String hexColor) {
  // Remove o caractere '#' do início, se presente
  if (hexColor.startsWith('#')) {
    hexColor = hexColor.substring(1);
  }

  // Verifique se a string possui um comprimento válido
  if (hexColor.length != 6) {
    throw const Color(0x00000000);
  }

  // Parse a string hexadecimal em valores RGB
  final int red = int.parse(hexColor.substring(0, 2), radix: 16);
  final int green = int.parse(hexColor.substring(2, 4), radix: 16);
  final int blue = int.parse(hexColor.substring(4, 6), radix: 16);

  // Crie e retorne a instância de Color
  return Color.fromRGBO(red, green, blue, 1.0);
}

extension StringToColor on String? {
  Color toColor() {
    if (this == null) {
      return Colors.white;
    }

    if (this?.isEmpty ?? true) {
      return Colors.white;
    }


    // Remove espaços em branco e caracteres especiais da string
    final cleanedString = this?.replaceAll(RegExp(r'[^\d,]'), '') ?? "";

    // Divide a string em valores R, G e B
    final rgbValues = cleanedString.split(',');

    if (rgbValues.length == 3) {
      try {
        final red = int.parse(rgbValues[0].trim());
        final green = int.parse(rgbValues[1].trim());
        final blue = int.parse(rgbValues[2].trim());
        return Color.fromARGB(255, red, green, blue);
      } catch (e) {
        throw Exception('Erro na conversão da string para Color: $e');
      }
    }

    // Retorna uma cor padrão (por exemplo, branco) se a conversão falhar
    return Colors.white;
  }

  String toColorHexa() {
    try {
      List<String> rgb = this?.split(',').map((v) => v.trim()).toList() ?? [];

      // Converte os valores RGB para inteiros
      int red = int.parse(rgb[0]);
      int green = int.parse(rgb[1]);
      int blue = int.parse(rgb[2]);

      // Assegura que os valores estejam no intervalo correto de 0 a 255
      assert(red >= 0 && red <= 255);
      assert(green >= 0 && green <= 255);
      assert(blue >= 0 && blue <= 255);

      // Converte os valores RGB para hexadecimal
      return red.toRadixString(16).padLeft(2, '0') +
             green.toRadixString(16).padLeft(2, '0') +
             blue.toRadixString(16).padLeft(2, '0');
    } catch (e) {
      throw Exception('Erro na conversão da string para Color: $e');
    }
  }
}

