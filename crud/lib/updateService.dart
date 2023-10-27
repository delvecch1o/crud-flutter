import 'package:crud/main.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:crud/drift.dart';
import 'package:crud/validate.dart';
import 'package:flutter/services.dart';

class EditServiceScreen extends StatefulWidget {
  final Service service;

  const EditServiceScreen({Key? key, required this.service}) : super(key: key);

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController frotaControllerAlter = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    idController.text = widget.service.id.toString();
    frotaControllerAlter.text = widget.service.frota;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Ordem de Serviço'),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 40),
            TextFormField(
              controller: frotaControllerAlter,
              decoration: const InputDecoration(labelText: 'Frota'),
            ),
            
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  int id = int.parse(idController.text);
                  String alteredFrota = frotaControllerAlter.text;
                  

                  if (isValidFrota(alteredFrota)

                    ) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Warning'),
                            content: const Text('Invalid update service'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Exit"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  } else {
                    database.updateServices(
                      ServicesCompanion(
                          id: Value(id),
                          frota: Value(alteredFrota),
                          ),
                    );
                    Navigator.pop(
                        context,
                        Service(
                            id: id,
                            frota: alteredFrota,
                           ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromARGB(255, 37, 107, 27)),
                ),
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
