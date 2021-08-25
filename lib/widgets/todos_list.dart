import 'package:flutter/material.dart';
import 'package:mobile/controllers/todos_controller.dart';
import 'package:mobile/pages/edit_todo_page.dart';

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
