import 'dart:math';

class Logic {
// Vigenere Cipher encryption and decryption
  String vigenere(String text, String key, bool fullVigenere, int encrypt,
      String alphabeth) {
    String result = '';
    String charUsed = alphabeth.toLowerCase();

    List listOfChar = [];

    for (var i = 0; i < charUsed.length; i++) {
      listOfChar.add(charUsed.codeUnitAt(i));
    }
    for (int i = 0, j = 0; i < text.length; i++) {
      int cu = text.toLowerCase().codeUnitAt(i);
      int ck = key.toLowerCase().codeUnitAt(j);

      int offset = 97;
      int x = 0, y = 0;

      if (cu == ' '.codeUnitAt(0)) {
        result += "";
        continue;
      }

      int a = listOfChar.indexOf(cu);
      int b = listOfChar.indexOf(ck);
      if (encrypt == 1) {
        if (fullVigenere) {
          /// set encrypt vigenere
          x = (a + b) % 26;

          result += String.fromCharCode(listOfChar[x]).toUpperCase();
        } else {
          /// encrypt regular vigenere
          x = ((cu + ck) - offset * 2) % 26;
          result += String.fromCharCode(x + offset).toUpperCase();
        }
      } else {
        if (fullVigenere) {
          /// decrypt full vigenere type
          x = (a - b) % 26;
          result += String.fromCharCode(listOfChar[x]);
        } else {
          // decrypt regular vigenere type
          y = (((cu) - ck)) % 26;
          result += String.fromCharCode(y + offset);
        }
      }

      j = (j + 1) % key.length;
    }
    if (encrypt == 1) {
      var r = Random().nextInt(4) + 1;
      var s = result.replaceAllMapped(
          RegExp(r'.{3}'), (match) => '${match.group(0)} ');
      return s;
    } else {
      return result;
    }
  }
}
