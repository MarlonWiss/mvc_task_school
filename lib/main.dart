import 'package:fluent_ui/fluent_ui.dart';
import 'package:mvc_task_school/view.dart';

// GitHub link: https://github.com/MarlonWiss/mvc_task_school

void main() {
  runApp(
    FluentApp(
      title: 'MVC Task School',
      theme: FluentThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
      ),
      home: const ViewPage(),
    ),
  );
}
