class Todo {
  final String title;
  final String description;
  final bool done;

  const Todo({
    this.title = '',
    this.description = '',
    this.done = false,
  });

  Todo copyWith({
    String title,
    String description,
    bool done,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'done': done,
    };
  }
}
