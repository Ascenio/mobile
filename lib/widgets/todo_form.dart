import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({
    Key key,
    this.title,
    this.description,
    @required this.onTitleChanged,
    @required this.onDescriptionChanged,
    @required this.onFormValidated,
  }) : super(key: key);

  final String title;
  final String description;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onFormValidated;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            initialValue: title,
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
            onChanged: onTitleChanged,
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: description,
            maxLines: null,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'I should take out the trash and clean the dog poop',
              border: OutlineInputBorder(),
            ),
            onChanged: onDescriptionChanged,
          ),
          Builder(
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (Form.of(context).validate()) {
                      onFormValidated();
                    }
                  },
                  child: Text('Save it'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
