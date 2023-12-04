import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getEvento() async {
  List<Map<String, dynamic>> eventos = [];
  QuerySnapshot queryEvento =
      await db.collection('events').where('user', isEqualTo: '1').get();

  queryEvento.docs.forEach((documento) {
    Map<String, dynamic> eventoData =
        (documento.data() as Map<String, dynamic>);
    eventoData['id'] = documento.id; // Agrega el campo 'id' al mapa de datos
    eventos.add(eventoData);
  });

  return eventos;
}
/*
Future<List> addEvent() async {
  await db.collection("events").add();

}


Future<List> getInvitacion() async {
  List invitaciones = [];
  CollectionReference collectionReferenceInvitacion =
      db.collection('invitaciones');
  QuerySnapshot queryInvitacion = await collectionReferenceInvitacion.get();
  return invitaciones;
}
 */
