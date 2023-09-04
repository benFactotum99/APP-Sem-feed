import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController? textController;
  final String myLabelText;
  final String? Function(String? value) onValidator;
  final void Function(String? value) onChanged;
  final bool readOnly;
  final int maxLines;
  final bool enable;
  final bool obscureText;

  const CustomTextForm(
      {this.textController = null,
      required this.myLabelText,
      required this.onValidator,
      required this.onChanged,
      this.obscureText = false,
      this.readOnly = false,
      this.enable = true,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      enabled: this.enable,
      maxLines: maxLines,
      readOnly: readOnly,
      controller: textController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: onValidator,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        labelText: myLabelText,
        labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        //prefixIcon: Icon(Icons.account_circle, size: 30),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
