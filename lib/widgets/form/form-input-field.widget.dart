import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  final Color borderColor;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const FormInputField({
    required this.borderColor,
    this.obscureText = false,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.validator,
    this.controller,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: _formInputDecoration(
          borderColor: borderColor,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }

  static InputDecoration _formInputDecoration({String? hintText, String? labelText, IconData? prefixIcon, required Color borderColor}) {
    return InputDecoration(
      isDense: true,
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      hintStyle: const TextStyle(
          color: Color(0xFFCCCCCC)
      ),
      prefixIcon: prefixIcon != null ? Icon(
        prefixIcon,
        size: 25,
      ) : null,
      label: Text(
        labelText ?? '',
        style: const TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
