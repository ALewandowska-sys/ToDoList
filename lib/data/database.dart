import 'package:database/data/model/theme_moor.dart';
import 'package:database/data/model/task_moor.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ThemeColors, Tasks], daos: [TaskDao, ThemeColorsDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super(SqfliteQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        ));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        beforeOpen: (OpeningDetails details) async {
          if (details.wasCreated) {
            await into(themeColors).insert(const ThemeColorsCompanion(
                colorName: Value(-623098), selected: Value(true)));
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
          }
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {}
        },
      );
}

@DriftAccessor(tables: [
  Tasks
], queries: {
  'totalTasks': 'SELECT COUNT(*) FROM tasks;',
  'totalToDo': 'SELECT COUNT(*) FROM tasks WHERE selected = false;'
})
class TaskDao extends DatabaseAccessor<MoorDatabase> with _$TaskDaoMixin {
  final MoorDatabase database;

  TaskDao(this.database) : super(database);

  Stream<int> getTotalRecords() => totalTasks().watchSingle();

  Stream<int> getToDoRecords() => totalToDo().watchSingle();

  // All tables have getters in the generated class - we can select the tasks table
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // Moor supports Streams which emit elements when the watched data changes
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Stream<List<Task>> watchDoneTasks() =>
      (select(tasks)..where((tbl) => tbl.selected.equals(true))).watch();

  Stream<List<Task>> watchToDoTasks() =>
      (select(tasks)..where((tbl) => tbl.selected.equals(false))).watch();

  Future insertTask(TasksCompanion task) => into(tasks).insert(task);

  // Updates a Task with a matching primary key
  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);
}

@DriftAccessor(tables: [
  ThemeColors
], queries: {
  'color': 'SELECT color_name FROM theme_colors WHERE selected = true;'
})
class ThemeColorsDao extends DatabaseAccessor<MoorDatabase>
    with _$ThemeColorsDaoMixin {
  final MoorDatabase database;

  ThemeColorsDao(this.database) : super(database);

  Stream<int> getColorQuery() => color().watchSingle();

  Stream<List<ThemeColor>> watchSelectColors() => select(themeColors).watch();

  Future insertColor(ThemeColorsCompanion themeCompanion) =>
      into(themeColors).insert(themeCompanion);

  Future updateColor(ThemeColor themeColor) =>
      update(themeColors).replace(themeColor);

  Future deleteColor(ThemeColor themeColor) =>
      delete(themeColors).delete(themeColor);
}
