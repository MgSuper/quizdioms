import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';

abstract class IdiomRemoteDataSource {
  Future<void> addIdiomGroup(IdiomGroup group);
  Future<List<IdiomGroup>> getIdiomGroups();
}

class IdiomRemoteDataSourceImpl implements IdiomRemoteDataSource {
  final FirebaseFirestore firestore;

  IdiomRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addIdiomGroup(IdiomGroup group) async {
    final collection = firestore.collection('idioms');

    try {
      await collection.doc(group.id).set(group.toFirestore());
    } catch (e) {
      // print('🔥 Firestore error: $e');
      // print(st);
    }
  }

  @override
  Future<List<IdiomGroup>> getIdiomGroups() async {
    try {
      final snapshot = await firestore
          .collection('idioms')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return idiomGroupFromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      // print('🔥 Firestore error: $e');
    }
    return [];
  }
}
