import 'package:diacritic/diacritic.dart';

String normalizeEnum(String value) {
  if (value.isEmpty) return value;

  return removeDiacritics(value) // remove acentos: Média → Media
      .replaceAll(" ", "_")      // troca espaços por _ : Em Andamento → EM_ANDAMENTO
      .toUpperCase();            // coloca upper
}
