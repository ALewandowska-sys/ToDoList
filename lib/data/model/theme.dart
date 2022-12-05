import 'package:drift/drift.dart';

class ThemeColors extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get colorName => integer()();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
}
