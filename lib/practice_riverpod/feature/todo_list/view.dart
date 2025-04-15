import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/practice_riverpod/feature/todo_list/components/add_new_task_bottom_sheet.dart';
import 'package:flutter_jr_sample/practice_riverpod/feature/todo_list/components/to_do_list_item.dart';
import 'package:flutter_jr_sample/practice_riverpod/feature/todo_list/todo_list_provider.dart';
import 'package:flutter_jr_sample/practice_riverpod/model/todo/entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        builder: (context) => const AddNewTaskBottomSheet(),
                      ),
                      child: const Text(
                        '+ New Task',
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                switch (todos) {
                  AsyncData(:final value) => ListView.builder(
                      itemCount: value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => TodoListItem(
                        todo: value[index],
                      ),
                    ),
                  AsyncError() => const Text('error'),
                  _ => const CircularProgressIndicator(),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
