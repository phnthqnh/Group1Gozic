import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? label;
  final Function(String)? onChanged;
  final IconData rightIcon;
  final bool showPassword;
  final bool readOnly;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.rightIcon,
    required this.showPassword,
    required this.readOnly
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.showPassword ? _obscureText : false,
      textAlignVertical: TextAlignVertical.center,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        hintText: widget.label,
        prefixIcon: Icon(widget.rightIcon),
        suffixIcon:
            widget.showPassword
                ? IconButton(
                  onPressed: () {
                    _togglePasswordVisibility();
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
                : null,
        border: UnderlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
