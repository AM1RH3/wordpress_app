import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildCustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextDirection formFieldtextDirection;
  final String labelName;

  const BuildCustomFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.formFieldtextDirection = TextDirection.rtl,
    required this.labelName,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        obscureText: obscureText,
        onChanged: onChanged,
        controller: controller,
        cursorColor: Constants.primaryColor,
        style: const TextStyle(
          fontFamily: 'Lalezar',
          fontSize: 20.0,
          height: 2.0,
        ),
        textDirection: formFieldtextDirection,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontFamily: 'Lalezar',
          ),
          hintTextDirection: TextDirection.rtl,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.primaryColor,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          label: Text(
            labelName,
            style: TextStyle(
              fontFamily: 'Lalezar',
              fontSize: 20.0,
              color: Constants.primaryColor,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
