import 'dart:math';

abstract class RandomColor {
  static String get getColor {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    String colorHex = '#${_toHex(r)}${_toHex(g)}${_toHex(b)}';
    return colorHex;
  }

  static String _toHex(int component) {
    String hex = component.toRadixString(16).padLeft(2, '0');
    return hex.toUpperCase();
  }
}
