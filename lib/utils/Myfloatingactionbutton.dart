// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class Myfloatingactionbutton extends StatelessWidget {
  Function()? onPressed;
  Myfloatingactionbutton({super.key , required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed , child: Icon(Icons.add_box_outlined),);
  }
}