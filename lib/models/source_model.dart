class SourceNews {
  String id;
  String name;

  SourceNews({required this.id, required this.name});

  factory SourceNews.fromJson(Map<String, dynamic> json) {
    return SourceNews(id: json['id'].toString(), name: json['name'].toString());
  }
}
