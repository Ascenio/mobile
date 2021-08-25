import 'package:flutter/material.dart';
import 'package:mobile/domain/todo.dart';
import 'package:mobile/widgets/todo_form.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key key}) : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  var todo = Todo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: TodoForm(
            onTitleChanged: (title) {
              todo = todo.copyWith(title: title);
            },
            onDescriptionChanged: (description) {
              todo = todo.copyWith(description: description);
            },
            onFormValidated: () {
              Navigator.of(context).pop(todo);
            },
          ),
        ),
      ),
    );
  }
}
