import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// By default, the name of the generated data class will be "Task" (without "s")
class Tasks extends Table {
  // autoIncrement automatically sets this to be the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
}
