import 'package:database/data/model/select_color_moor.dart';
import 'package:database/data/model/task_moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';


// By default, the name of the generated data class will be "Task" (without "s")
class Tasks extends Table {
  // autoIncrement automatically sets this to be the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
}


class SelectColors extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get colorName => integer()();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
}


@UseMoor(tables: [Tasks, SelectColors])
// _$AppDatabase is the name of the generated class
class AppDatabase extends _$AppDatabase {
  AppDatabase()
  // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    // Good for debugging - prints SQL in the console
    logStatements: true,
  )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

  // All tables have getters in the generated class - we can select the tasks table
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // Moor supports Streams which emit elements when the watched data changes
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Stream<List<Task>> watchDoneTasks() => (select(tasks)
    ..where((tbl) => tbl.selected.equals(true)))
      .watch();

  Stream<List<Task>> watchToDoTasks() => (select(tasks)
    ..where((tbl) => tbl.selected.equals(false)))
      .watch();

  Future insertTask(TasksCompanion task) => into(tasks).insert(task);

  // Updates a Task with a matching primary key
  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);

  Stream<List<SelectColor>> getColor() => (select(selectColors)
    ..where((tbl) => tbl.selected.equals(true)))
      .watch();

  Future insertColor(SelectColorsCompanion color) => into(selectColors).insert(color);

  Future updateColor(SelectColor color) => update(selectColors).replace(color);

  Future deleteColor(SelectColor color) => delete(selectColors).delete(color);
}

@UseDao(tables: [Tasks],
    queries: {'totalTasks': 'SELECT COUNT(*) FROM tasks;',
      'totalToDo': 'SELECT COUNT(*) FROM tasks WHERE selected = false;'})
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin  {

  final AppDatabase database;

  TaskDao(this.database) : super(database);

  Future<int> getTotalRecords() {
    return totalTasks().getSingle();
  }
  Future<int> getToDoRecords() {
    return totalToDo().getSingle();
  }
}