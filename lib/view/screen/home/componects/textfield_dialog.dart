import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  const TextFieldDialog({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) =>
        (value!.isEmpty || value == '') ? 'Enter details' : null,
        controller: textEditingController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ));
  }
}