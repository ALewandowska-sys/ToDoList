import 'package:database/data/model/theme_moor.dart';
import 'package:database/data/model/task_moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@UseMoor(tables: [ThemeColors, Tasks], daos: [TaskDao, ThemeColorsDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    // Good for debugging - prints SQL in the console
    logStatements: true,
  ));

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) {
      return m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      await into(themeColors).insert(const ThemeColorsCompanion(
          colorName: Value(-623098),
          selected: Value(true)
      ));
      await into(themeColors).insert(const ThemeColorsCompanion(
        colorName: Value(-51967434),
      ));
      await into(themeColors).insert(const ThemeColorsCompanion(
        colorName: Value(-334336),
      ));
      await into(themeColors).insert(const ThemeColorsCompanion(
        colorName: Value(-12856517),
      ));
      await into(themeColors).insert(const ThemeColorsCompanion(
        colorName: Value(-2466604),
      ));
      await into(themeColors).insert(const ThemeColorsCompanion(
        colorName: Value(-13795108),
      ));
    },
  );
}

@UseDao(tables: [Tasks],
    queries: {'totalTasks': 'SELECT COUNT(*) FROM tasks;',
      'totalToDo': 'SELECT COUNT(*) FROM tasks WHERE selected = false;'})
class TaskDao extends DatabaseAccessor<MoorDatabase> with _$TaskDaoMixin  {

  final MoorDatabase database;

  TaskDao(this.database) : super(database);

  Future<int> getTotalRecords() => totalTasks().getSingle();

  Future<int> getToDoRecords() => totalToDo().getSingle();

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
}

@UseDao(tables: [ThemeColors], queries: {'countQuery': 'SELECT COUNT(*) FROM theme_colors;',
  'color': 'SELECT color_name FROM theme_colors WHERE selected = true;'})
class ThemeColorsDao extends DatabaseAccessor<MoorDatabase> with _$ThemeColorsDaoMixin  {

  final MoorDatabase database;

  ThemeColorsDao(this.database) : super(database);

  Future<int> count() => countQuery().getSingle();

  Future<int> getColorQuery() => color().getSingle();

  Stream<List<ThemeColor>> watchSelectColors() => select(themeColors).watch();

  Future insertColor(ThemeColorsCompanion themeCompanion) => into(themeColors).insert(themeCompanion);

  Future updateColor(ThemeColor themeColor) => update(themeColors).replace(themeColor);

  Future deleteColor(ThemeColor themeColor) => delete(themeColors).delete(themeColor);

}