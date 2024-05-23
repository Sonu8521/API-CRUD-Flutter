class Todosdatamodel {
  int userId;
  int id;
  String title;
  bool completed;

  Todosdatamodel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todosdatamodel.fromJson(Map<String, dynamic> json) {
    return Todosdatamodel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}