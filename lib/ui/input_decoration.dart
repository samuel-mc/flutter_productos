import 'package:flutter/material.dart';
import '../helpers/custom_colors.dart';

class InputDecorations {
  static InputDecoration authInputDecorations(
      {required String placeholder, required String label, IconData? icono}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.purple)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.darkBlue, width: 2)),
        hintText: placeholder,
        labelText: label,
        labelStyle: const TextStyle(color: CustomColors.darkBlue),
        prefixIcon: icono != null
            ? Icon(
                icono,
                color: CustomColors.purple,
              )
            : null);
  }
}
