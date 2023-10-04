import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onTapOutside: (v) => FocusScope.of(context).unfocus(),
        onChanged: widget.onChanged,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: 'Wpisz liczby przedzielone przecinkami',
          labelText: 'Liczby wejściowe',
          suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                widget.controller.clear();
                FocusScope.of(context).unfocus();
              }),
        ),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))],
      ),
    );
  }
}
