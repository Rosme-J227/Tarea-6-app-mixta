class NewsModel {
  final String title;
  final String summary;
  final String link;
  final String imageUrl;

  NewsModel({
    required this.title,
    required this.summary,
    required this.link,
    required this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    String extractImage() {
      try {
        return json['yoast_head_json']['og_image'][0]['url'] ?? '';
      } catch (e) {
        return '';
      }
    }

    return NewsModel(
      title: json['title']?['rendered'] ?? 'Sin Título',
      summary: json['excerpt']?['rendered'] ?? 'Sin Resumen',
      link: json['link'] ?? '',
      imageUrl: extractImage(),
    );
  }
}
