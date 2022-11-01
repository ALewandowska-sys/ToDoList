import 'package:database/data/model/select_color_moor.dart';
import 'package:database/data/model/task_moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

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
  int get schemaVersion => 2;

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

  Stream<SelectColor> getColor() => (select(selectColors)
    ..where((tbl) => tbl.selected.equals(true)))
      .watchSingle();

  Stream<List<SelectColor>> watchSelectColors() => select(selectColors).watch();

  Future insertColor(SelectColorsCompanion color) => into(selectColors).insert(color);

  Future updateColor(SelectColor color) => update(selectColors).replace(color);

  Future deleteColor(SelectColor color) => delete(selectColors).delete(color);

  
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) {
      return m.createAll();
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        await into(selectColors).insert(const SelectColorsCompanion(
          colorName: Value(-623098),
          selected: Value(true)
        ));
        await into(selectColors).insert(const SelectColorsCompanion(
          colorName: Value(-51967434),
        ));
        await into(selectColors).insert(const SelectColorsCompanion(
          colorName: Value(-334336),
        ));
        await into(selectColors).insert(const SelectColorsCompanion(
          colorName: Value(-12856517),
        ));
        await into(selectColors).insert(const SelectColorsCompanion(
          colorName: Value(-2466604),
        ));
        await into(selectColors).insert(const SelectColorsCompanion(
          colorName: Value(-13795108),
        ));
      }
    },
  );
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