import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//leemos la base de datos
Future<List> getPeople() async {
  //Inicializamos la lista con los datos
  List people = [];
  CollectionReference collectionReferencePeople = db.collection('people');
  //obtenemos los datos
  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  //recorremos los datos
  queryPeople.docs.forEach((element) {
    people.add(element.data());
  });
  return people;
}

//añadimos datos a la base de datos
Future<void> addPeople(String name) async {
  //Inicializamos la BD
  CollectionReference collectionReferencePeople = db.collection('people');
  //añadimos los datos
  await collectionReferencePeople.add({'name': name});
}
