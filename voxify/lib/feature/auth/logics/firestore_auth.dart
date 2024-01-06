import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voxify/feature/auth/abstract/base_firestore_service.dart';

// Define FirestoreService which extends BaseFirestoreService
class FirestoreService extends BaseFireStoreService {
  // Initialize Firestore instance
  final _firestoreInstance = FirebaseFirestore.instance;

  // Override addToFirestore method
  @override
  Future addToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      // Add data to Firestore
      await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .set(data);
    } catch (e) {
      // Throw exception if any error occurs
      throw Exception(e.toString());
    }
  }

  // Override updateDataToFirestore method
  @override
  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      // Update data in Firestore
      _firestoreInstance.collection(collectionName).doc(docName).update(data);
    } catch (e) {
      // Throw exception if any error occurs
      throw Exception(e.toString());
    }
  }
}
