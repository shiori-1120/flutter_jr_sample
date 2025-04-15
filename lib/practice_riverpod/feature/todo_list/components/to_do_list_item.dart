import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/category_type/category_type_enum.dart';
import 'package:flutter_jr_sample/practice_riverpod/feature/todo_list/todo_list_provider.dart';
import 'package:flutter_jr_sample/practice_riverpod/model/todo/entity.dart';
import 'package:flutter_jr_sample/practice_riverpod/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class TodoListItem extends ConsumerWidget {
  const TodoListItem({
    required this.todo,
    super.key,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('todo list item');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: TodoCategory.getColor(todo.category),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton(
                      icon: const Icon(CupertinoIcons.delete),
                      onPressed: () async {
                        await ref
                            .read(todoListProvider.notifier)
                            .deleteTodo(todo.id);
                      },
                    ),
                    title: Text(
                      todo.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration:
                            todo.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(
                      todo.description,
                      maxLines: 1,
                      style: TextStyle(
                        decoration:
                            todo.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        shape: const CircleBorder(),
                        value: todo.isDone,
                        onChanged: (value) async {
                          await ref
                              .read(todoListProvider.notifier)
                              .toggleIsDone(todo.id, isDone: todo.isDone);
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          children: [
                            const Text('deadline'),
                            const Gap(12),
                            Text(
                              '${todo.limitAt?.month}月${todo.limitAt?.day}日',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
