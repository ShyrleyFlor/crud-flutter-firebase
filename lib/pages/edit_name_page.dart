import 'package:crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  TextEditingController nameController = TextEditingController(text: " ");

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments["name"];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar nombre'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await editPeople(
                    arguments["id"],
                    nameController.text,
                  ).then((_) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  });
                  },
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ));
  }
}
