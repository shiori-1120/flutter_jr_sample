import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/category_type/category_type_enum.dart';

class TodoTypeRadioButtons extends StatelessWidget {
  const TodoTypeRadioButtons({
    required this.selectedCategory,
    required this.onCategoryChanged,
    super.key,
  });

  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (final category in TodoCategory.values)
            Expanded(
              child: Material(
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: category.color),
                  child: RadioListTile<String>(
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
                    value: category.displayName,
                    groupValue: selectedCategory,
                    onChanged: (value) => onCategoryChanged(value!),
                  ),
                ),
              ),
            ),
        ],
      );
}
