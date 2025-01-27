// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;


  MyButtons({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.secondary,
      child: Text(buttonName),
    );
  }
}
