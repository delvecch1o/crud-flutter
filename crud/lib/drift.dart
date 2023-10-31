import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

part 'drift.g.dart';

@UseRowClass(Service)
class Services extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get frota => text()();
  TextColumn get modelo => text()();
  TextColumn get setor => text()();
  TextColumn get descricao => text()();
}

class Service {
  final int id;
  final String frota;
  final String modelo;
  final String setor;
  final String descricao;

  Service({
    required this.id,
    required this.frota,
    required this.modelo,
    required this.setor,
    required this.descricao,
  });
}

@DriftDatabase(tables: [Services])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Service>> viewServices() => select(services).get();
  Future<int> insertServices(ServicesCompanion service) =>
      into(services).insert(service);
  Future updateServices(ServicesCompanion service) =>
      update(services).replace(service);
  Future deleteServices(ServicesCompanion service) =>
      delete(services).delete(service);
}

DatabaseConnection _openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: 'services_list',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (db.missingFeatures.isNotEmpty) {
      print('error - missing features');
    }

    return db.resolvedExecutor;
  }));
}