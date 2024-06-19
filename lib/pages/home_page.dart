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
                return Text(snapshot.data![index]['name']);
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