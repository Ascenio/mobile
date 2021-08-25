import 'package:flutter/material.dart';
import 'package:mobile/domain/todo.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key key}) : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  String _title;
  String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
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
                    _title = title;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText:
                        'I should take out the trash and clean the dog poop',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (description) {
                    _description = description;
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
                            final todo = Todo(
                              title: _title,
                              description: _description ?? '',
                            );
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
