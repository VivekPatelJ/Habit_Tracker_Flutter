import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_application/datetime/date_time.dart'; // Adjusted import based on your project

// reference our box
final _myBox = Hive.box('Mybox');

class Taskdatabase {
  List tasks = [];
  Map<DateTime, int> heatMapDataSet = {};

  // create initial default data
  void Creatinitdata() {
    tasks = [
      ["Run", false],
      ["Read", false],
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exists
  void lodadata() {
    // if it's a new day, get task list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      tasks = _myBox.get("CURRENT_TASK_LIST");
      // set all tasks to incomplete since it's a new day
      for (int i = 0; i < tasks.length; i++) {
        tasks[i][1] = false;
      }
    }
    // if it's not a new day, load today's list
    else {
      tasks = _myBox.get(todaysDateFormatted());
    }
  }

  // update database
  void uppdatedata() {
    // update today's entry
    _myBox.put(todaysDateFormatted(), tasks);

    // update universal task list in case it changed (new task, edit task, delete task)
    _myBox.put("CURRENT_TASK_LIST", tasks);

    // calculate task complete percentages for each day
    calculateTaskPercentages();

    // load heat map
    loadHeatMap();
  }

  // Calculate completion percentage of tasks
  void calculateTaskPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = tasks.isEmpty
        ? '0.0'
        : (countCompleted / tasks.length).toStringAsFixed(1);

    // key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0.0-1.0 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  // Load heat map data
  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
