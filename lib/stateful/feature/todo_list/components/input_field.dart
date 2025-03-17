import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.maxLines,
    required this.hintText,
    required this.txtController,
    this.isRequired = false,
    super.key,
  });

  final String hintText;
  final int maxLines;
  final TextEditingController txtController;
  final bool isRequired;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: txtController,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
          ),
          validator: (value) => isRequired && value!.isEmpty
              ? 'This field cannot be empty'
              : null,
          maxLines: maxLines,
        ),
      );
}
