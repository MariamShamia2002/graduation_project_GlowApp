import 'package:flutter/material.dart';
import 'package:Glow/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isObscure;
  final String? errorText;
  final IconData? icon;
  final String? hintText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isObscure = false,
    this.errorText,
    this.icon,
    this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: TextField(
        controller: controller,
        obscureText: isObscure ?? false,
        keyboardType: keyboardType,
        cursorColor: kBackgroundColor,
        decoration: InputDecoration(
          errorText: errorText,
          suffixIcon: Icon(
            icon,
            color: kBackgroundColor,
          ),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kTitleColor,
            ),
          ),
        ),
      ),
    );
  }
}
