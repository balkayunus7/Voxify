abstract class BaseFireStoreService {
  Future addToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);

  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);
}
