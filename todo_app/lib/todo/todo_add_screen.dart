import 'package:flutter/material.dart';
import 'package:todo_app/todo/todo_entity.dart';

class TodoAddScreen extends StatelessWidget {
  final idTextCrtler = TextEditingController();
  final titleTextCrtler = TextEditingController();
  final descriptionTextCrtler = TextEditingController();
  TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: idTextCrtler,
              decoration: const InputDecoration(
                hintText: "Id",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: titleTextCrtler,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionTextCrtler,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  final id = idTextCrtler.text;
                  final title = titleTextCrtler.text;
                  final description = descriptionTextCrtler.text;

                  TodoEntity(id: id, title: title, description: description)
                      .save()
                      .then((value) => Navigator.pop(context));
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
