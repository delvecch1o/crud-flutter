// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $ServicesTable extends Services with TableInfo<$ServicesTable, Service> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _frotaMeta = const VerificationMeta('frota');
  @override
  late final GeneratedColumn<String> frota = GeneratedColumn<String>(
      'frota', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
      'modelo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setorMeta = const VerificationMeta('setor');
  @override
  late final GeneratedColumn<String> setor = GeneratedColumn<String>(
      'setor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, frota, modelo, setor, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(Insertable<Service> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('frota')) {
      context.handle(
          _frotaMeta, frota.isAcceptableOrUnknown(data['frota']!, _frotaMeta));
    } else if (isInserting) {
      context.missing(_frotaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(_modeloMeta,
          modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta));
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('setor')) {
      context.handle(
          _setorMeta, setor.isAcceptableOrUnknown(data['setor']!, _setorMeta));
    } else if (isInserting) {
      context.missing(_setorMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Service map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Service(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      frota: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frota'])!,
      modelo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modelo'])!,
      setor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}setor'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }
}

class ServicesCompanion extends UpdateCompanion<Service> {
  final Value<int> id;
  final Value<String> frota;
  final Value<String> modelo;
  final Value<String> setor;
  final Value<String> descricao;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.frota = const Value.absent(),
    this.modelo = const Value.absent(),
    this.setor = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  ServicesCompanion.insert({
    this.id = const Value.absent(),
    required String frota,
    required String modelo,
    required String setor,
    required String descricao,
  })  : frota = Value(frota),
        modelo = Value(modelo),
        setor = Value(setor),
        descricao = Value(descricao);
  static Insertable<Service> custom({
    Expression<int>? id,
    Expression<String>? frota,
    Expression<String>? modelo,
    Expression<String>? setor,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (frota != null) 'frota': frota,
      if (modelo != null) 'modelo': modelo,
      if (setor != null) 'setor': setor,
      if (descricao != null) 'descricao': descricao,
    });
  }

  ServicesCompanion copyWith(
      {Value<int>? id,
      Value<String>? frota,
      Value<String>? modelo,
      Value<String>? setor,
      Value<String>? descricao}) {
    return ServicesCompanion(
      id: id ?? this.id,
      frota: frota ?? this.frota,
      modelo: modelo ?? this.modelo,
      setor: setor ?? this.setor,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (frota.present) {
      map['frota'] = Variable<String>(frota.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (setor.present) {
      map['setor'] = Variable<String>(setor.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('frota: $frota, ')
          ..write('modelo: $modelo, ')
          ..write('setor: $setor, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ServicesTable services = $ServicesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [services];
}
