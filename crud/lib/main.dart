import 'package:crud/drift.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/services.dart';
import 'validate.dart';
import 'updateService.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController frotaController = TextEditingController();
TextEditingController modeloController = TextEditingController();
TextEditingController setorController = TextEditingController();
TextEditingController descricaoController = TextEditingController();

final List<Service> _services = [];
final database = AppDatabase();
final TextEditingController _controller = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Ordem de Serviço',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ordem de Serviço - MANUTENÇÃO'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServicesListScreen(),
              ));
            },
            child: const Text('Criar Ordem de Serviço'),
          ),
        ));
  }
}

class ServicesListScreen extends StatefulWidget {
  const ServicesListScreen({super.key});

  @override
  ServicesListScreenState createState() => ServicesListScreenState();
}

class ServicesListScreenState extends State<ServicesListScreen> {
  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    await database.viewServices().then((services) {
      setState(
        () {
          _services.clear();
          _services.addAll(services);
        },
      );
    });
  }

  Future<void> _removeService(Service service) async {
    await database
        .deleteServices(
          ServicesCompanion(
            id: Value(service.id),
            frota: Value(service.frota),
            modelo: Value(service.modelo),
            setor: Value(service.setor),
            descricao: Value(service.descricao),
          ),
        )
        .then((_) => _loadServices());
  }

  Future<void> _attService(Service service) async {
    final alteredService = ServicesCompanion(
      id: Value(service.id),
      frota: Value(service.frota),
      modelo: Value(service.modelo),
      setor: Value(service.setor),
      descricao: Value(service.descricao),
    );
    await database.updateServices(alteredService).then((_) => _loadServices());
  }

  Future<void> _addServices(
      String frota, String modelo, String setor, String descricao) async {
    final newService = ServicesCompanion.insert(
        frota: frota, modelo: modelo, setor: setor, descricao: descricao);

    await database.insertServices(newService).then((_) {
      _loadServices();
      _controller.clear();
    });
  }

  List listItemSetor = ["CD - Secos", "CD - Frios", "CD - FLV", "CD - Reversa"];

  List listItemModelo = [ "EXR - Direção Mecânica", "ERX - Direção Elétrica", "EGU - 20C", "EGU - T18", "Linde RC - 17", "FMX - NG" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O.S')),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _services.length,
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 71, 82, 59),
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: ListTile(
                  textColor: Colors.white,
                  title: Text('Frota: ${_services[i].frota} '),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modelo: ${_services[i].modelo}',
                      ),
                      Text(
                        'Setor: ${_services[i].setor}',
                      ),
                      Text(
                        'Descricao: ${_services[i].descricao}',
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditServiceScreen(service: _services[i]),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                _services[i] = result;
                              });
                            }
                          },
                          color: const Color(0xFFF7D00E),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _removeService(_services[i]);
                          },
                          color: Color.fromARGB(255, 209, 7, 7),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Adicionar O.S'),
                content: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: frotaController,
                      decoration:
                          const InputDecoration(labelText: 'Frota: Ex. P10'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Modelo'),
                        items: listItemModelo
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        onChanged: (selectModelo) {
                          modeloController.text = selectModelo!;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Setor'),
                        items: listItemSetor
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        onChanged: (selectSetor) {
                          setorController.text = selectSetor!;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: descricaoController,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                    ),
                  ),
                ]),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      String frota = frotaController.text;
                      String modelo = modeloController.text;
                      String setor = setorController.text;
                      String descricao = descricaoController.text;

                      if (isValidFrota(frota) ||
                          isValidModelo(modelo) ||
                          isValidSetor(setor) ||
                          isValidDescricao(descricao)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Warning"),
                              content: const Text("Invalid service"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Exit"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        _addServices(frota, modelo, setor, descricao);
                        Navigator.of(context).pop();
                        frotaController.clear();
                        modeloController.clear();
                        setorController.clear();
                        descricaoController.clear();
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: const Color(0xFF646464),
        child: const Icon(Icons.add),
      ),
    );
  }
}