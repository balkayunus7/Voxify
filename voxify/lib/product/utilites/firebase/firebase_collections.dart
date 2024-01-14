import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  users,
  // ignore: constant_identifier_names
  chat_rooms,
  messages,
  timestamp;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}