import 'package:flutter/material.dart';
import 'package:mobile/todo.dart';

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
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  initialValue: todo.title,
                  autofocus: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Can't be empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Cleanup the house',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (title) {
                    todo = todo.copyWith(title: title);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: todo.description,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText:
                        'I should take out the trash and clean the dog poop',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (description) {
                    todo = todo.copyWith(description: description);
                  },
                ),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (Form.of(context).validate()) {
                            Form.of(context).save();
                            Navigator.of(context).pop(todo);
                          }
                        },
                        child: Text('Save it'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
