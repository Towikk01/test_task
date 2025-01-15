class Todo {
  final String id;
  final String title;
  final String description;
  final String category;
  final String isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = 'Uncompleted',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'isCompleted': isCompleted,
      };

  @override
  String toString() {
    return 'id: $id, title: $title, description: $description, category: $category, isCompleted: $isCompleted';
  }

  bool isCompletedBool () {
    return isCompleted == 'Completed';
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      isCompleted: json['isCompleted'],
    );
  }

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
