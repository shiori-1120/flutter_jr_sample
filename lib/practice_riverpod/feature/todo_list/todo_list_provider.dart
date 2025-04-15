import 'package:flutter_jr_sample/practice_riverpod/model/todo/entity.dart';
import 'package:flutter_jr_sample/practice_riverpod/provider/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async => getTodos();

  Future<List<Todo>> getTodos() async {
    final List<Todo> todos = await ref
        .read(firestoreProvider)
        .collection(Todo.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) => Todo.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return todos;
  }

  Future<void> addTodos(Todo todo) async {
    await ref
        .read(firestoreProvider)
        .collection(Todo.collectionName)
        .doc(todo.id)
        .set(todo.toJson());

    final previousState = await future;

    state = AsyncData([...previousState, todo]);
  }

  Future<void> deleteTodo(String id) async {
    await ref
        .read(firestoreProvider)
        .collection(Todo.collectionName)
        .doc(id)
        .delete();

    final previousState = await future;
    previousState.removeWhere((value) => value.id == id);
    state = AsyncData(previousState);
  }

  Future<void> toggleIsDone(String id, {required bool isDone}) async {
    await ref
        .read(firestoreProvider)
        .collection(Todo.collectionName)
        .doc(id)
        .update({'isDone': isDone});

    final previousState = await future;
    final index = previousState.indexWhere((value) => value.id == id);
    previousState[index] = previousState[index].copyWith(isDone: !isDone);
    state = AsyncData(previousState);
  }
}
