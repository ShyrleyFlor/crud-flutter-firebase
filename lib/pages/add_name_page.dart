import 'package:crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Añadir nombre'),
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
                  await addPeople(nameController.text).then((_) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  });
                },
                child: const Text('Añadir'),
              ),
            ],
          ),
        ));
  }
}
