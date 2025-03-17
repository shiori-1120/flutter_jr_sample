import 'package:flutter/material.dart';

enum TodoCategory {
  lrn('LRN', Colors.red),
  wrk('WRK', Colors.blue),
  gen('GEN', Colors.amber);

  const TodoCategory(this.displayName, this.color);
  final String displayName;
  final Color color;

  static String toDisplayName(int index) => switch (index) {
        0 => 'LRN',
        1 => 'WRK',
        2 => 'GEN',
        _ => 'General',
      };
  static Color getColor(String category) => switch (category) {
        'LRN' => TodoCategory.lrn.color,
        'WRK' => TodoCategory.wrk.color,
        'GEN' => TodoCategory.gen.color,
        _ => TodoCategory.lrn.color,
      };

  static int toIndex(String category) => switch (category) {
        'LRN' => TodoCategory.lrn.index,
        'WRK' => TodoCategory.wrk.index,
        'GEN' => TodoCategory.gen.index,
        _ => 0,
      };
}
