// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:localstore/localstore.dart';

class TodoEntity {
  final String id;
  final String title;
  final String description;
  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
  });

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoEntity.fromJson(String source) =>
      TodoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ToDoEntity(id: $id, title: $title, description: $description)';

  // Sử dụng localstore
  // Định nghĩa phương thức save và delete cho đối tượng todo
  Future<void> save() async {
    final db = Localstore.instance;
    await db.collection('todos').doc(id).set(toMap());
  }

  Future<void> delete() async {
    final db = Localstore.instance;
    await db.collection('todos').doc(id).delete();
  }
}
