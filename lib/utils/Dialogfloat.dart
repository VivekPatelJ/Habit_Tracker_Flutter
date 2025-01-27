// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last, must_be_immutable, unused_field, non_constant_identifier_names, prefer_typing_uninitialized_variables, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:task_manager_application/utils/my_buttons.dart';

class Dialogfloat extends StatefulWidget {
  final TextEditingController Controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  Dialogfloat({
    super.key,
    required this.Controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  _DialogfloatState createState() => _DialogfloatState();
}

class _DialogfloatState extends State<Dialogfloat> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 160, // Adjusted height as needed
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              controller: widget.Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'A D D  T A S K S   H E R E',
                hintStyle: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButtons(buttonName: "S A V E", onPressed: widget.onSave),
                MyButtons(buttonName: "C A N C E L", onPressed: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
