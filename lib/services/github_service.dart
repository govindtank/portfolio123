import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_project.dart';

class GithubService {
  static const String _baseUrl = 'https://api.github.com/users/govindtank/repos';

  Future<List<GithubProject>> fetchRecentRepos() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?sort=updated&per_page=6'),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<GithubProject> projects = body
            .map((dynamic item) => GithubProject.fromJson(item))
            .toList();
        return projects;
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e) {
      print('Error fetching Github projects: $e');
      return [];
    }
  }
}
