// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String name;
  final bool selected;
  Task({required this.id, required this.name, required this.selected});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      selected: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}selected'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['selected'] = Variable<bool>(selected);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      name: Value(name),
      selected: Value(selected),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      selected: serializer.fromJson<bool>(json['selected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'selected': serializer.toJson<bool>(selected),
    };
  }

  Task copyWith({int? id, String? name, bool? selected}) => Task(
        id: id ?? this.id,
        name: name ?? this.name,
        selected: selected ?? this.selected,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('selected: $selected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, selected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.name == this.name &&
          other.selected == this.selected);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> selected;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.selected = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.selected = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? selected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (selected != null) 'selected': selected,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<bool>? selected}) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      selected: selected ?? this.selected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (selected.present) {
      map['selected'] = Variable<bool>(selected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('selected: $selected')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _selectedMeta = const VerificationMeta('selected');
  @override
  late final GeneratedColumn<bool?> selected = GeneratedColumn<bool?>(
      'selected', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (selected IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, selected];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('selected')) {
      context.handle(_selectedMeta,
          selected.isAcceptableOrUnknown(data['selected']!, _selectedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class SelectColor extends DataClass implements Insertable<SelectColor> {
  final int id;
  final int colorName;
  final bool selected;
  SelectColor(
      {required this.id, required this.colorName, required this.selected});
  factory SelectColor.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SelectColor(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      colorName: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color_name'])!,
      selected: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}selected'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color_name'] = Variable<int>(colorName);
    map['selected'] = Variable<bool>(selected);
    return map;
  }

  SelectColorsCompanion toCompanion(bool nullToAbsent) {
    return SelectColorsCompanion(
      id: Value(id),
      colorName: Value(colorName),
      selected: Value(selected),
    );
  }

  factory SelectColor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SelectColor(
      id: serializer.fromJson<int>(json['id']),
      colorName: serializer.fromJson<int>(json['colorName']),
      selected: serializer.fromJson<bool>(json['selected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'colorName': serializer.toJson<int>(colorName),
      'selected': serializer.toJson<bool>(selected),
    };
  }

  SelectColor copyWith({int? id, int? colorName, bool? selected}) =>
      SelectColor(
        id: id ?? this.id,
        colorName: colorName ?? this.colorName,
        selected: selected ?? this.selected,
      );
  @override
  String toString() {
    return (StringBuffer('SelectColor(')
          ..write('id: $id, ')
          ..write('colorName: $colorName, ')
          ..write('selected: $selected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, colorName, selected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SelectColor &&
          other.id == this.id &&
          other.colorName == this.colorName &&
          other.selected == this.selected);
}

class SelectColorsCompanion extends UpdateCompanion<SelectColor> {
  final Value<int> id;
  final Value<int> colorName;
  final Value<bool> selected;
  const SelectColorsCompanion({
    this.id = const Value.absent(),
    this.colorName = const Value.absent(),
    this.selected = const Value.absent(),
  });
  SelectColorsCompanion.insert({
    this.id = const Value.absent(),
    required int colorName,
    this.selected = const Value.absent(),
  }) : colorName = Value(colorName);
  static Insertable<SelectColor> custom({
    Expression<int>? id,
    Expression<int>? colorName,
    Expression<bool>? selected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (colorName != null) 'color_name': colorName,
      if (selected != null) 'selected': selected,
    });
  }

  SelectColorsCompanion copyWith(
      {Value<int>? id, Value<int>? colorName, Value<bool>? selected}) {
    return SelectColorsCompanion(
      id: id ?? this.id,
      colorName: colorName ?? this.colorName,
      selected: selected ?? this.selected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (colorName.present) {
      map['color_name'] = Variable<int>(colorName.value);
    }
    if (selected.present) {
      map['selected'] = Variable<bool>(selected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SelectColorsCompanion(')
          ..write('id: $id, ')
          ..write('colorName: $colorName, ')
          ..write('selected: $selected')
          ..write(')'))
        .toString();
  }
}

class $SelectColorsTable extends SelectColors
    with TableInfo<$SelectColorsTable, SelectColor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SelectColorsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _colorNameMeta = const VerificationMeta('colorName');
  @override
  late final GeneratedColumn<int?> colorName = GeneratedColumn<int?>(
      'color_name', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _selectedMeta = const VerificationMeta('selected');
  @override
  late final GeneratedColumn<bool?> selected = GeneratedColumn<bool?>(
      'selected', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (selected IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, colorName, selected];
  @override
  String get aliasedName => _alias ?? 'select_colors';
  @override
  String get actualTableName => 'select_colors';
  @override
  VerificationContext validateIntegrity(Insertable<SelectColor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('color_name')) {
      context.handle(_colorNameMeta,
          colorName.isAcceptableOrUnknown(data['color_name']!, _colorNameMeta));
    } else if (isInserting) {
      context.missing(_colorNameMeta);
    }
    if (data.containsKey('selected')) {
      context.handle(_selectedMeta,
          selected.isAcceptableOrUnknown(data['selected']!, _selectedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SelectColor map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SelectColor.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SelectColorsTable createAlias(String alias) {
    return $SelectColorsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $SelectColorsTable selectColors = $SelectColorsTable(this);
  late final TaskDao taskDao = TaskDao(this as AppDatabase);
  late final ColorDao colorDao = ColorDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, selectColors];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $TasksTable get tasks => attachedDatabase.tasks;
  Selectable<int> totalTasks() {
    return customSelect('SELECT COUNT(*) FROM tasks;',
        variables: [],
        readsFrom: {
          tasks,
        }).map((QueryRow row) => row.read<int>('COUNT(*)'));
  }

  Selectable<int> totalToDo() {
    return customSelect('SELECT COUNT(*) FROM tasks WHERE selected = false;',
        variables: [],
        readsFrom: {
          tasks,
        }).map((QueryRow row) => row.read<int>('COUNT(*)'));
  }
}
mixin _$ColorDaoMixin on DatabaseAccessor<AppDatabase> {
  $SelectColorsTable get selectColors => attachedDatabase.selectColors;
}
