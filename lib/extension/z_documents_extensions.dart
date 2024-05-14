import 'package:zezis_functions/zezis_functions.dart';

String formatDocument(String document) {
  if (document.isNullOrEmpty()) { return ""; }

  // Remove qualquer caractere que não seja numérico
  document = document.replaceAll(RegExp(r'[^\d]'), '');
  
  // Verifica se a string possui 11 ou 14 caracteres numéricos
  if (document.length == 11) {
    // Formata o CPF com pontos e hífen
    return "${document.substring(0, 3)}.${document.substring(3, 6)}.${document.substring(6, 9)}-${document.substring(9)}";
  } else if (document.length == 14) {
    // Formata o CNPJ com pontos e hífen
    return "${document.substring(0, 2)}.${document.substring(2, 5)}.${document.substring(5, 8)}/${document.substring(8, 12)}-${document.substring(12)}";
  }
  
  // Se a string não tiver 11 ou 14 caracteres numéricos, retorna a string original
  return document;
}
