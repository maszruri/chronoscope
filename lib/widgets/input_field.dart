import 'package:chronoscope/constants/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Icon pIcon;
  final String hint;
  final TextInputType textInputType;
  final Widget? suffix;
  final bool? isObscure;
  const InputField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.pIcon,
    required this.textInputType,
    this.isObscure,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(right: 10),
      child: TextFormField(
        obscureText: isObscure ?? false,
        controller: textEditingController,
        style: const TextStyle(color: accentColor),
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: pIcon,
          prefixIconColor: secondaryColor,
          hintText: hint,
          suffix: suffix,
        ),
      ),
    );
  }
}
