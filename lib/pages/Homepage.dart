// ignore_for_file: prefer_const_constructors, file_names, deprecated_member_use, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_label, duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Import Slidable
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_application/data/database.dart';
import 'package:task_manager_application/theme/theme_provider.dart';
import 'package:task_manager_application/utils/Dialogfloat.dart';
import 'package:task_manager_application/utils/Track_tiles.dart';
import 'package:task_manager_application/utils/month_summary.dart';

class Homepage extends StatefulWidget {
  final TextEditingController _controller = TextEditingController();

  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late final AnimationController _themeAnimationController;

  Taskdatabase db = Taskdatabase();
  bool themeChange = false;

  final Mybox = Hive.box('Mybox');

  @override
  void initState() {
    super.initState();
    _themeAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,  
    );

    // Load data
    if (Mybox.get("TASKS") == null) {
      db.Creatinitdata();
    } else {
      db.lodadata();
    }
  }

  @override
  void dispose() {
    _themeAnimationController.dispose();
    super.dispose();
  }

  void taskCheck(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = value ?? false;
    });
    db.uppdatedata();
  }

  void saveTask() {
    setState(() {
      db.tasks.add([widget._controller.text, false]);
      widget._controller.clear();
    });
    Navigator.of(context).pop();
    db.uppdatedata();
  }

  void showFloatButton() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogfloat(
          Controller: widget._controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveTask,
        );
      },
    );
  }

  void editTasks(int index) {
    widget._controller.text = db.tasks[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return Dialogfloat(
          Controller: widget._controller,
          onSave: () {
            setState(() {
              db.tasks[index][0] = widget._controller.text;
            });
            Navigator.of(context).pop();
            db.uppdatedata();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTasks(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.uppdatedata();
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final task = db.tasks.removeAt(oldIndex);
      db.tasks.insert(newIndex, task);
    });
    db.uppdatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: Lottie.network(
              'https://lottie.host/68e8ee3b-a926-4099-ac8d-d8f61f865468/oALzb0tEMO.json',
              controller: _themeAnimationController,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.task_alt,
                size: 100,
              ),
            ),
            ListTile(
              title: Text('H O M E'),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text('T A S K  T R A C K E R'),
              leading: Icon(Icons.task),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tasktracker');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: Mybox.get("START_DATE"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.tasks.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(index),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => editTasks(index),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => deleteTasks(index),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: TrackTiles(
                  trackName: db.tasks[index][0],
                  trackCompleted: db.tasks[index][1],
                  onChanged: (value) => taskCheck(value, index),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showFloatButton,
        child: Icon(Icons.add_box),
      ),
    );
  }
}
