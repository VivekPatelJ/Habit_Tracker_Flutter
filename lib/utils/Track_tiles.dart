// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class TrackTiles extends StatelessWidget {
  final String trackName;
  final bool trackCompleted;
  Function(bool?)? onChanged;
 TrackTiles({super.key , required this.trackName , required this.trackCompleted , required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15 , right: 15 , top: 15),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary , borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Checkbox(value: trackCompleted, onChanged:onChanged, activeColor: Theme.of(context).colorScheme.secondary, ),
            Text(trackName , style: TextStyle(fontSize: 16.0,decoration:trackCompleted? TextDecoration.lineThrough : TextDecoration.none),),
          ],
        ),
      ),
    );
  }
}
