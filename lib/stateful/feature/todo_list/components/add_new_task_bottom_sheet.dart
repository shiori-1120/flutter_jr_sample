import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/category_type/category_type_enum.dart';
import 'package:flutter_jr_sample/constants/app_style.dart';
import 'package:flutter_jr_sample/stateful/feature/todo_list/components/date_time.dart';
import 'package:flutter_jr_sample/stateful/feature/todo_list/components/input_field.dart';
import 'package:flutter_jr_sample/stateful/feature/todo_list/components/todo_type_radio_buttons.dart';
import 'package:flutter_jr_sample/stateful/model/todo/entity.dart';
import 'package:gap/gap.dart';

class AddNewTaskBottomSheet extends StatefulWidget {
  const AddNewTaskBottomSheet({required this.onTaskAdded, super.key});

  final ValueChanged<Todo> onTaskAdded;

  @override
  State<AddNewTaskBottomSheet> createState() => _AddNewTaskBottomSheetState();
}

class _AddNewTaskBottomSheetState extends State<AddNewTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = TodoCategory.lrn.displayName;
  DateTime limitAt = DateTime.now();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Task Todo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Divider(
                thickness: 1.2,
                color: Colors.grey,
              ),
              const Gap(12),

              // タイトル入力
              const Text(
                'Title Task',
                style: AppStyle.headingOne,
              ),
              const Gap(6),
              Form(
                key: _formKey,
                child: InputField(
                  maxLines: 1,
                  hintText: 'Add Task Name',
                  txtController: titleController,
                  isRequired: true,
                ),
              ),
              const Gap(12),

              // 説明入力
              const Text(
                'Description',
                style: AppStyle.headingOne,
              ),
              const Gap(6),
              InputField(
                maxLines: 5,
                hintText: 'Add Descriptions',
                txtController: descriptionController,
              ),
              const Gap(12),

              // カテゴリ選択
              const Text(
                'Category',
                style: AppStyle.headingOne,
              ),
              TodoTypeRadioButtons(
                selectedCategory: selectedCategory,
                onCategoryChanged: (newCategory) {
                  setState(() => selectedCategory = newCategory);
                },
              ),

              // 日付と時間の選択
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimeWidget(
                    titleText: 'Date',
                    valueText:
                        '${limitAt.day}/${limitAt.month}/${limitAt.year}',
                    iconSection: CupertinoIcons.calendar,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: limitAt,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2026),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          limitAt = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            limitAt.hour,
                            limitAt.minute,
                          );
                        });
                      }
                    },
                  ),
                  const Gap(22),
                  DateTimeWidget(
                    titleText: 'Time',
                    valueText: '${limitAt.hour}:${limitAt.minute}',
                    iconSection: CupertinoIcons.clock,
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: limitAt.hour,
                          minute: limitAt.minute,
                        ),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          limitAt = DateTime(
                            limitAt.year,
                            limitAt.month,
                            limitAt.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    },
                  ),
                ],
              ),

              // ボタン
              const Gap(12),
              Row(
                children: [
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onTaskAdded(
                            Todo(
                              id: '',
                              title: titleController.text,
                              description: descriptionController.text,
                              category: selectedCategory,
                              limitAt: limitAt,
                              isDone: false,
                            ),
                          );
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
