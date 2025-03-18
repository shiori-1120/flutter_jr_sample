import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_jr_sample/category_type/category_type_enum.dart';
import 'package:flutter_jr_sample/constants/app_style.dart';
import 'package:flutter_jr_sample/riverpod/feature/todo_list/components/date_time.dart';
import 'package:flutter_jr_sample/riverpod/feature/todo_list/components/input_field.dart';
import 'package:flutter_jr_sample/riverpod/feature/todo_list/components/todo_type_radio_buttons.dart';
import 'package:flutter_jr_sample/riverpod/feature/todo_list/vm.dart';
import 'package:flutter_jr_sample/riverpod/model/todo/entity.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddNewTaskBottomSheet extends HookConsumerWidget {
  const AddNewTaskBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    /// タイトル入力用のコントローラー
    final titleController = useTextEditingController();

    /// 説明入力用のコントローラー
    final descriptionController = useTextEditingController();

    /// 選択されたカテゴリを保持する状態
    final selectedCategory = useState<String>(TodoCategory.lrn.displayName);

    /// 締め切り日時を保持する状態
    final limitedAt = useState<DateTime>(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// タイトル
            const SizedBox(
              width: double.infinity,
              child: Text(
                'New Task Todo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(
              thickness: 1.2,
              color: Colors.grey,
            ),
            const Gap(12),

            /// タスクのタイトル入力フィールド
            const Text(
              'Title Task',
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            Form(
              key: formKey,
              child: InputField(
                maxLines: 1,
                hintText: 'Add Task Name',
                txtController: titleController,
                isRequired: true,
              ),
            ),
            const Gap(12),

            /// タスクの説明入力フィールド
            const Text('Description', style: AppStyle.headingOne),
            const Gap(6),
            InputField(
              maxLines: 5,
              hintText: 'Add Descriptions',
              txtController: descriptionController,
            ),
            const Gap(12),

            /// カテゴリ選択ラジオボタン
            const Text('Category', style: AppStyle.headingOne),
            TodoTypeRadioButtons(selectedCategory: selectedCategory),

            /// 日付と時間の選択セクション
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  titleText: 'Date',
                  valueText:
                      '${limitedAt.value.day}/${limitedAt.value.month}/${limitedAt.value.year}',
                  iconSection: CupertinoIcons.calendar,
                  onTap: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      initialDate: limitedAt.value,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2026),
                    );

                    if (getValue != null) {
                      limitedAt.value = DateTime(
                        getValue.year,
                        getValue.month,
                        getValue.day,
                        limitedAt.value.hour,
                        limitedAt.value.minute,
                      );
                    }
                  },
                ),
                const Gap(22),
                DateTimeWidget(
                  titleText: 'Time',
                  valueText:
                      '${limitedAt.value.hour}:${limitedAt.value.minute}',
                  iconSection: CupertinoIcons.clock,
                  onTap: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: limitedAt.value.hour,
                        minute: limitedAt.value.minute,
                      ),
                    );

                    if (getTime != null && context.mounted) {
                      limitedAt.value = DateTime(
                        limitedAt.value.year,
                        limitedAt.value.month,
                        limitedAt.value.day,
                        getTime.hour,
                        getTime.minute,
                      );
                    }
                  },
                ),
              ],
            ),

            /// ボタンセクション
            const Gap(12),
            Row(
              children: [
                /// キャンセルボタン
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(20),

                /// 作成ボタン
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      /// バリデーション実施
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      await ref
                          .read(todoListPageViewModelProvider.notifier)
                          .addNewTask(
                            Todo(
                              id: '',
                              title: titleController.text,
                              description: descriptionController.text,
                              category: selectedCategory.value,
                              limitAt: limitedAt.value,
                              isDone: false,
                            ),
                          );

                      titleController.clear();
                      descriptionController.clear();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
