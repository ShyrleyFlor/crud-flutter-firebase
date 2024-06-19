import 'package:crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Mi AppBar',
          style: TextStyle(
            color: Colors.white, 
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getPeople() ,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          title: Text("¿Estas seguro de eliminar a ${snapshot.data![index]['name']}?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              }, 
                              child: const Text("Cancelar")
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              }, 
                              child: const Text("Sí")
                            )
                          ]);
                      });
                    return result;
                  },
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data![index]['id']);
                    snapshot.data!.removeAt(index);
                    setState(() {});
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data![index]['id']),
                  child: ListTile(
                    title: Text(snapshot.data![index]['name']),
                    onTap: (() async {await Navigator.pushNamed(
                      context, '/edit', 
                      arguments: {
                        "name": snapshot.data![index]['name'],
                        "id": snapshot.data![index]['id'],
                      });
                      setState(() {});
                    })
                  ),
                );
              },
            );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    )),
    floatingActionButton: FloatingActionButton(
      onPressed: () async{
        await Navigator.pushNamed(context, '/add');
        setState(() {});
      },
      child: const Icon(Icons.add),
    ),
  );
  }
}