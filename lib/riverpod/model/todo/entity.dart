import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jr_sample/utils/time_stamp_conveter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required String description,
    required String category,
    required bool isDone,
    @TimestampConverter() DateTime? limitAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  static String collectionName = 'todos';
}
