import 'package:flutter/material.dart';

import 'package:flutter_jr_sample/stateful/feature/todo_list/components/add_new_task_bottom_sheet.dart';
import 'package:flutter_jr_sample/stateful/feature/todo_list/components/to_do_list_item.dart';
import 'package:flutter_jr_sample/stateful/logic/repository.dart';
import 'package:flutter_jr_sample/stateful/model/todo/entity.dart';

import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoLogic = TodoLogic();
  List<Todo> _todos = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    // ignore: discarded_futures
    _loadTodos(); // 非同期メソッドを呼び出すが `await` しない
  }

  Future<void> _loadTodos() async {
    final todos = await _todoLogic.getTodos();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  Future<void> _addNewTask(Todo todo) async {
    final id = await _todoLogic.addNewTask(todo);
    setState(() {
      _todos.add(todo.copyWith(id: id));
    });
  }

  Future<void> _deleteTask(String id) async {
    await _todoLogic.deleteTask(id);
    setState(() {
      _todos.removeWhere((item) => item.id == id);
    });
  }

  Future<void> _completeTask(String id, {required bool isDone}) async {
    await _todoLogic.updateTask(id, isDone: isDone);
    setState(() {
      _todos = _todos
          .map((item) => item.id == id ? item.copyWith(isDone: isDone) : item)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today's Task",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Wednesday, 11 May',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD5E8FA),
                                foregroundColor: Colors.blue.shade800,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async => showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                context: context,
                                builder: (context) => AddNewTaskBottomSheet(
                                  onTaskAdded: _addNewTask,
                                ),
                              ),
                              child: const Text(
                                '+ New Task',
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        ListView.builder(
                          itemCount: _todos.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TodoListItem(
                            todo: _todos[index],
                            onDelete: () async => _deleteTask(_todos[index].id),
                            onToggleComplete: (isDone) async =>
                                _completeTask(_todos[index].id, isDone: isDone),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
}
