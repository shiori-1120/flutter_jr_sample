import 'package:flutter_jr_sample/riverpod/model/todo/entity.dart';
import 'package:flutter_jr_sample/riverpod/repository/todo/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vm.g.dart';
part 'vm.freezed.dart';

@freezed
abstract class TodoListPageState with _$TodoListPageState {
  const factory TodoListPageState({
    required List<Todo> todos,
  }) = _TodoPageState;
}

@riverpod
class TodoListPageViewModel extends _$TodoListPageViewModel {
  TodoRepository get todoRepo => ref.read(todoRepoProvider);

  @override
  Future<TodoListPageState> build() async {
    final cache = ref.read(todoRepoCacheProvider);
    if (cache.isNotEmpty) {
      return TodoListPageState(todos: cache.values.toList());
    }
    final fetchedTodos = await todoRepo.getTodos();
    return TodoListPageState(todos: fetchedTodos);
  }

  void _updateStateFromCache() {
    final cache = ref.read(todoRepoCacheProvider);
    state = AsyncData(TodoListPageState(todos: cache.values.toList()));
  }

  Future<void> addNewTask(Todo todo) async {
    await todoRepo.addNewTask(todo);
    _updateStateFromCache();
  }

  Future<void> deleteTask(String id) async {
    await todoRepo.deleteTask(id);
    _updateStateFromCache();
  }

  Future<void> completeTask(String id, {required bool isDone}) async {
    await todoRepo.updateTask(id, isDone: isDone);
    _updateStateFromCache();
  }
}
