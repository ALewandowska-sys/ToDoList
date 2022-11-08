import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Tasks extends Table {
  // autoIncrement automatically sets this to be the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
}
