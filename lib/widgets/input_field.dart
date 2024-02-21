import 'package:chronoscope/constants/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Icon pIcon;
  final Icon? sIcon;
  final String hint;
  final TextInputType textInputType;
  const InputField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.pIcon,
    required this.textInputType,
    this.sIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: textEditingController,
        style: const TextStyle(color: accentColor),
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: pIcon,
          prefixIconColor: secondaryColor,
          hintText: hint,
        ),
      ),
    );
  }
}
