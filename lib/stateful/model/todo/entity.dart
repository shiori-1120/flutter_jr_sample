import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jr_sample/utils/time_stamp_conveter.dart';

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isDone,
    this.limitAt,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final bool isDone;
  @TimestampConverter()
  final DateTime? limitAt;

  static const String collectionName = 'todos';

  /// Firestore から取得したデータを `Todo` クラスに変換
  // ignore: sort_constructors_first
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        isDone: json['isDone'] as bool,
        limitAt: json['limitAt'] != null
            ? const TimestampConverter().fromJson(json['limitAt'] as Timestamp)
            : null,
      );

  /// `Todo` クラスのデータを Firestore に保存できる JSON に変換
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'isDone': isDone,
        'limitAt':
            limitAt != null ? const TimestampConverter().toJson(limitAt) : null,
      };

  /// `copyWith` メソッドを手動で作成
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    bool? isDone,
    DateTime? limitAt,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        isDone: isDone ?? this.isDone,
        limitAt: limitAt ?? this.limitAt,
      );
}
