// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, must_be_immutable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  Function(BuildContext)? editTask;

  TaskTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteTask,
      required this.editTask
      });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: widget.deleteTask,
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
            startActionPane: ActionPane(motion: BehindMotion(), children: [
              SlidableAction(
                onPressed: widget.editTask,
                icon: Icons.edit,
                backgroundColor: Colors.green.shade300,
                borderRadius: BorderRadius.circular(10),
              )
            ]),
            child: Container(
              child: Row(
                children: [
                  Checkbox(
                    value: widget.taskCompleted,
                    onChanged: widget.onChanged,
                    activeColor:Theme.of(context).colorScheme.secondary,
                  ),
                  Text(
                    widget.taskName,
                    style: TextStyle(
                        decoration: widget.taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
              padding: EdgeInsets.all(24.0),
              width: 400,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
