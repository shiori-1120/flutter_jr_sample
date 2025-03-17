import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jr_sample/stateful/model/todo/entity.dart';

class TodoLogic {
  factory TodoLogic() => _instance;
  TodoLogic._internal();
  static final TodoLogic _instance = TodoLogic._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Todo> get collection =>
      _db.collection(Todo.collectionName).withConverter<Todo>(
            fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );

  Future<List<Todo>> getTodos() async => [
        ...await collection
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList()),
      ];

  Future<String> addNewTask(Todo todo) async {
    final DocumentReference docRef = await collection.add(todo);
    await docRef.update({'id': docRef.id});
    return docRef.id;
  }

  Future<void> deleteTask(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateTask(String id, {required bool isDone}) async {
    await collection.doc(id).update({'isDone': isDone});
  }
}
