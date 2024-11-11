import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogTextField extends StatefulWidget {
  final TextInputType? ketBordTybe;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  const LogTextField(
      {super.key,
      required this.hint,
      required this.controller,
      this.ketBordTybe,
      this.isPassword = false,
      this.validator});

  @override
  State<LogTextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<LogTextField> {
  bool isVissible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
      child: TextFormField(
        validator: widget.validator,
        keyboardType: widget.ketBordTybe,
        obscureText: widget.isPassword && !isVissible,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVissible = !isVissible;
                    });
                  },
                  icon: isVissible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.white)),
          hintText: widget.hint,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 70, 70, 70),
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 15),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
