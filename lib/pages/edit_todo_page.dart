import 'package:flutter/material.dart';
import 'package:mobile/domain/todo.dart';
import 'package:mobile/widgets/todo_form.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  Todo todo;

  @override
  void initState() {
    super.initState();
    todo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: TodoForm(
            title: todo.title,
            description: todo.description,
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
