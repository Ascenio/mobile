import 'package:flutter/material.dart';

import 'create_todo_page.dart';
import 'edit_todo_page.dart';
import 'todos_controller.dart';

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

class TodosList extends StatelessWidget {
  const TodosList({
    Key key,
    @required TodosController controller,
  })  : _controller = controller,
        super(key: key);

  final TodosController _controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.todos.length,
      itemBuilder: (context, index) {
        final todo = _controller.todos[index];
        return Dismissible(
          key: ObjectKey(todo),
          onDismissed: (_) {
            _controller.remove(index);
          },
          child: ListTile(
            title: Text(todo.title),
            subtitle: todo.description.isNotEmpty
                ? Text(todo.description)
                : const SizedBox(),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch.adaptive(
                  value: todo.done,
                  onChanged: (_) {
                    _controller.toggle(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final updatedTodo = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditTodoPage(todo: todo),
                      ),
                    );
                    _controller.update(updatedTodo, index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NoTodosFound extends StatelessWidget {
  const NoTodosFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Looks like you have no todos yet 😎',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
