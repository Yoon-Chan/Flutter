class Todo {
  String? title;
  String? content;
  int? active;
  int? id;

  Todo(
      { required this.title, required this.content,this.active, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'content' : content,
      'active' : active,
    };
  }
}