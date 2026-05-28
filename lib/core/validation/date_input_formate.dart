import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {

      buffer.write(text[i]);

      int nonZeroIndex = i + 1;

      if ((nonZeroIndex == 2 || nonZeroIndex == 4)
          && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    String formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}