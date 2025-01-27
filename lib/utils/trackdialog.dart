// ignore_for_file: prefer_const_constructors, sort_child_properties_last, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class trackdialog extends StatelessWidget {

  final controller;

  final VoidCallback Onsave;

  final VoidCallback Oncancel;

  const trackdialog({super.key , required this.controller , required this.Onsave , required this.Oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary))),
      ),
      actions: [
        MaterialButton(
          onPressed: Onsave,
          child: Text('S A V E'),
          color: Theme.of(context).colorScheme.primary,
        ),
        MaterialButton(
          onPressed: Oncancel,
          child: Text('C A N C E L'),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
