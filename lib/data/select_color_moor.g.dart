// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_color_moor.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
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

abstract class _$ColorDatabase extends GeneratedDatabase {
  _$ColorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SelectColorsTable selectColors = $SelectColorsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [selectColors];
}
