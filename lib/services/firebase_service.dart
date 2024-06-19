import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//LEER LOS DATOS
Future<List> getPeople() async {
  //Inicializamos la lista con los datos
  List people = [];
  //obtenemos los datos
  QuerySnapshot queryPeople = await db.collection('people').get();
  //recorremos los datos
  for(var doc in queryPeople.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name" : data['name'],
      "id": doc.id,
    };
    people.add(person);
  }
  return people;
}

//AÑADIR LOS DATOS
Future<void> addPeople(String name) async {
  //añadimos los datos
  await db.collection('people').add({'name': name});
}

//EDITAR LOS DATOS  
Future<void> editPeople(String id, String name) async {
  //editamos los datos
  await db.collection('people').doc(id).update({'name': name});
}

//ELIMINAR LOS DATOS
Future<void> deletePeople(String id) async {
  //eliminamos los datos
  await db.collection('people').doc(id).delete();
}