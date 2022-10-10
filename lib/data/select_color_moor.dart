import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'select_color_moor.g.dart';

class SelectColors extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get colorName => integer()();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
}


@UseMoor(tables: [SelectColors])
// _$AppDatabase is the name of the generated class
class ColorDatabase extends _$ColorDatabase {
  ColorDatabase()
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

  Future<List<SelectColor>> getColor() => (select(selectColors)
    ..where((tbl) => tbl.selected.equals(true))).get();

  Future insertColor(SelectColorsCompanion color) => into(selectColors).insert(color);

  Future updateColor(SelectColor color) => update(selectColors).replace(color);

  Future deleteColor(SelectColor color) => delete(selectColors).delete(color);
}