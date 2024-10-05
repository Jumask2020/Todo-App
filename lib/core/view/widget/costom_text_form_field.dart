import 'package:flutter/material.dart';

class CostomTextFormField extends StatelessWidget {
  const CostomTextFormField(
      {super.key,
      this.hintText,
      this.controller,
      this.validator,
      this.onTap,
      this.suffixIcon,
      this.readOnly,
      this.maxLines, this.vertical});
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final bool? readOnly;
  final int? maxLines;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: vertical?? 1, horizontal: 10),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
