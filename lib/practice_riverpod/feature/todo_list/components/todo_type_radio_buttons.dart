import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_jr_sample/category_type/category_type_enum.dart';

class TodoTypeRadioButtons extends HookWidget {
  const TodoTypeRadioButtons({
    required this.selectedCategory,
    super.key,
  });

  final ValueNotifier<String> selectedCategory;
  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (final category in TodoCategory.values)
            Expanded(
              child: Material(
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: category.color),
                  child: RadioListTile(
                    activeColor: category.color,
                    contentPadding: EdgeInsets.zero,
                    title: Transform.translate(
                      offset: const Offset(-22, 0),
                      child: Text(
                        category.displayName,
                        style: TextStyle(
                          color: category.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    value: category.index,
                    groupValue: TodoCategory.toIndex(selectedCategory.value),
                    onChanged: (value) => selectedCategory.value =
                        TodoCategory.toDisplayName(category.index),
                  ),
                ),
              ),
            ),
        ],
      );
}
