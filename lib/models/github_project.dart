class GithubProject {
  final String name;
  final String description;
  final String htmlUrl;
  final String language;
  final int stargazersCount;
  final String? avatarUrl;

  GithubProject({
    required this.name,
    required this.description,
    required this.htmlUrl,
    required this.language,
    required this.stargazersCount,
    this.avatarUrl,
  });

  factory GithubProject.fromJson(Map<String, dynamic> json) {
    return GithubProject(
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      htmlUrl: json['html_url'] as String,
      language: json['language'] as String? ?? 'Unknown',
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      avatarUrl: json['owner'] != null ? json['owner']['avatar_url'] as String? : null,
    );
  }
}
