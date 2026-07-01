class UniversityModel {
  final String name;
  final String domain;
  final String webPage;

  UniversityModel({
    required this.name,
    required this.domain,
    required this.webPage,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] ?? '',
      domain: (json['domains'] != null && (json['domains'] as List).isNotEmpty)
          ? json['domains'][0]
          : 'No domain',
      webPage: (json['web_pages'] != null && (json['web_pages'] as List).isNotEmpty)
          ? json['web_pages'][0]
          : '',
    );
  }
}
