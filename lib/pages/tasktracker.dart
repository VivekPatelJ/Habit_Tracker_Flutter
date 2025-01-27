// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_application/utils/Track_tiles.dart';

import '../theme/theme_provider.dart';
import '../utils/Myfloatingactionbutton.dart';
import '../utils/trackdialog.dart'; // Import provider

class tasktracker extends StatefulWidget {
  const tasktracker({super.key});

  @override
  State<tasktracker> createState() => _tasktrackerState();
}

class _tasktrackerState extends State<tasktracker>
    with SingleTickerProviderStateMixin {
  List tracklist = [
    ["Morning", false],
    ["Morning 2", true]
  ];

  void savetrack() {
    setState(() {
      tracklist.add([trackbox.text, false]);
    });
    trackbox.clear();
    Navigator.of(context).pop();
  }

  void tracksCompleted(bool? value, int index) {
    setState(() {
      tracklist[index][1] = value;
    });
  }

  final trackbox = TextEditingController();

  void createtracks() {
    showDialog(
      context: context,
      builder: (context) {
        return trackdialog(
          controller: trackbox,
          Onsave: savetrack,
          Oncancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  late final AnimationController _themeAnimationController;
  bool themeChange = false; // Track the theme change

  @override
  void initState() {
    super.initState();
    _themeAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _themeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Myfloatingactionbutton(
        onPressed: createtracks,
      ),
      appBar: AppBar(
        title: Text('T A S K  M A N A G E R'),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                themeChange = !themeChange;
                if (themeChange) {
                  _themeAnimationController.forward();
                } else {
                  _themeAnimationController.reverse();
                }
              });
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(); // Toggles the theme
            },
            child: Lottie.network(
              'https://lottie.host/ffcfb346-8a84-405d-85f6-527234cc84d6/09j6ryqRFn.json',
              controller: _themeAnimationController,
              width: 60,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      body: ListView.builder(
        itemCount: tracklist.length,
        itemBuilder: (BuildContext context, int index) {
          return TrackTiles(
            trackName: tracklist[index][0],
            trackCompleted: tracklist[index][1],
            onChanged: (value) => tracksCompleted(value, index),
          );
        },
      ),
    );
  }
}
