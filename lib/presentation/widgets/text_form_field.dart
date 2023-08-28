import 'package:flutter/material.dart';
import 'package:nsfsheild/utils/strings.dart';
import 'package:nsfsheild/utils/theme.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.inputType,
    this.onChanged,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final void Function(String)? onChanged;
  final IconData? icon;
  final bool isLoading;

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _isObscure = false;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.inputType == TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: _isObscure,
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: (val) {
          if (val!.isEmpty) {
            return '${AppStrings.ktypeYour} ${widget.labelText.toLowerCase()}!';
          }
          return null;
        },
        cursorColor: theme.colorScheme.primary,
        keyboardType: widget.inputType,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.inputType == TextInputType.visiblePassword
              ? IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: theme.colorScheme.tertiary,
            ),
          )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary),
            borderRadius: BorderRadius.circular(12.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.error),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.error),
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          prefixIcon: widget.icon != null
              ? Icon(
            widget.icon,
            color: theme.colorScheme.tertiary,
          )
              : null,
        ),
      ),
    );
  }
}
