class News {
  final String id;
  final String title;
  final String categoryId;
  final String content;

  News({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        categoryId: json['category']?['id'] ?? '',
        content: json['content'] ?? '');
  }
}
