import 'package:flutter_jr_sample/riverpod/model/todo/entity.dart';
import 'package:flutter_jr_sample/riverpod/repository/todo/repository.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vm.g.dart';
part 'vm.freezed.dart';

@freezed
abstract class TodoListPageState with _$TodoListPageState {
  const factory TodoListPageState({required List<Todo> todos}) = _TodoPageState;
}

@riverpod
class TodoListPageViewModel extends _$TodoListPageViewModel {
  TodoRepository get todoRepo => ref.read(todoRepoProvider);
  @override
  Future<TodoListPageState> build() async =>
      TodoListPageState(todos: await todoRepo.getTodos());

  Future<void> addNewTask(Todo todo) async {
    final res = await todoRepo.addNewTask(todo);
    state = AsyncData(
      state.requireValue.copyWith(
        todos: [...state.requireValue.todos, res],
      ),
    );
  }

  Future<void> deleteTask(String id) async {
    await todoRepo.deleteTask(id);
    state = AsyncData(
      state.requireValue.copyWith(
        todos: state.requireValue.todos.where((item) => item.id != id).toList(),
      ),
    );
  }

  Future<void> completeTask(String id, {required bool isDone}) async {
    await todoRepo.updateTask(id, isDone: isDone);
    state = AsyncData(
      state.requireValue.copyWith(
        todos: state.requireValue.todos
            .map((item) => item.id == id ? item.copyWith(isDone: isDone) : item)
            .toList(),
      ),
    );
  }
}
