import 'package:flutter/material.dart';
import 'package:web_view_authentication/constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  const TextFormFieldWidget({
    Key? key,
    this.controller,
    this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: primarySwatch),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
