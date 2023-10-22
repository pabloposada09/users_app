import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? hint;
  final String? label;
  final String? errorMessage;
  final String? title;
  final String? errorFormatText;
  final String? cancelMessage;
  final String? acceptMessage;

  const CustomDatePicker({
    super.key,
    required this.onChanged,
    this.hint,
    this.label,
    this.errorMessage,
    this.title,
    this.errorFormatText,
    this.cancelMessage,
    this.acceptMessage,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: themeColors.secondary,
        ));

    return DateTimePicker(
      type: DateTimePickerType.date,
      initialDate: DateTime(2023),
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      onChanged: onChanged,
      autovalidate: true,
      calendarTitle: title,
      errorFormatText: errorFormatText,
      cancelText: cancelMessage,
      confirmText: acceptMessage,
      decoration: InputDecoration(
          label: label != null ? Text(label!) : null,
          errorText: errorMessage,
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
    );
  }
}
