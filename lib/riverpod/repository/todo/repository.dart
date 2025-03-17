import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jr_sample/riverpod/model/todo/entity.dart';
import 'package:flutter_jr_sample/riverpod/provider/firebase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository.g.dart';

@riverpod
TodoRepository todoRepo(Ref ref) => TodoRepository(ref: ref);

@Riverpod(keepAlive: true)
class TodoRepoCache extends _$TodoRepoCache {
  @override
  Map<String, Todo> build() => {};

  void update(String id, Todo todo) {
    state = {...state, id: todo};
  }

  void remove(String id) {
    state = {...state}..remove(id);
  }

  void setAll(List<Todo> todos) {
    state = {for (final todo in todos) todo.id: todo};
  }
}

class TodoRepository {
  TodoRepository({required Ref ref}) : _ref = ref;
  final Ref _ref;
  FirebaseFirestore get db => _ref.read(firestoreProvider);
  CollectionReference<Todo> get collection => _ref
      .read(firestoreProvider)
      .collection(Todo.collectionName)
      .withConverter<Todo>(
        fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );

  Future<List<Todo>> getTodos() async {
    final data = await collection
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    _ref.read(todoRepoCacheProvider.notifier).setAll(data);
    return data;
  }

  Future<void> addNewTask(Todo todo) async {
    final docRef = await collection.add(todo);
    final data = todo.copyWith(id: docRef.id);
    _ref.read(todoRepoCacheProvider.notifier).update(data.id, data);
  }

  Future<void> deleteTask(String id) async {
    await collection.doc(id).delete();
    _ref.read(todoRepoCacheProvider.notifier).remove(id);
  }

  Future<void> updateTask(String id, {required bool isDone}) async {
    await collection.doc(id).update({'isDone': isDone});
    final cacheData = _ref.read(todoRepoCacheProvider)[id];
    if (cacheData != null) {
      _ref
          .read(todoRepoCacheProvider.notifier)
          .update(id, cacheData.copyWith(isDone: isDone));
    }
  }
}
