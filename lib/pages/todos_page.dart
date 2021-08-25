import 'package:flutter/material.dart';
import 'package:mobile/controllers/todos_controller.dart';
import 'package:mobile/widgets/loading.dart';
import 'package:mobile/widgets/not_found.dart';
import 'package:mobile/widgets/todos_list.dart';

import 'create_todo_page.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key key}) : super(key: key);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  TodosController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TodosController()..initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My to-dos'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          Widget child;
          if (_controller.status == ControllerStatus.loading) {
            return Loading();
          } else if (_controller.todos.isEmpty) {
            child = NoTodosFound();
          } else {
            child = TodosList(controller: _controller);
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: child,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreateTodoPage()));
          _controller.add(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
