class AlbumsDatamodel {
  final int userId;
  final int id;
  final String title;

  AlbumsDatamodel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumsDatamodel.fromJson(Map<String, dynamic> json) {
    return AlbumsDatamodel(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}