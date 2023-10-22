import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;

  const CustomFormField({
    super.key,
    this.label,
    this.hintText,
    this.onChanged,
    this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: themeColors.secondary,
        ));

    return TextFormField(
      decoration: InputDecoration(
          label: label != null ? Text(label!) : null,
          hintText: hintText,
          errorText: errorText,
          border: inputBorder,
          focusedBorder: inputBorder.copyWith(
            borderSide: BorderSide(
              color: themeColors.primary,
            ),
          ),
          errorBorder: inputBorder.copyWith(
              borderSide: const BorderSide(
            color: Colors.redAccent,
          ))),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
