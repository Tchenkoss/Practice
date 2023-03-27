import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  late TextEditingController controller = TextEditingController();
  late String? username;
  late String labelText;
  late bool obscureText = false;
  late String hintText;
  late IconData? iconField;
  dynamic onValidator;

  TextFieldWidget(
      {super.key,
      this.username,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.iconField,
      this.obscureText = false,
      required this.onValidator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(iconField),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: labelText.toString(),
        hintText: hintText.toString(),
      ),
    );
  }
}
