import 'package:phonon_github/api/api_base_helper.dart';
import 'package:phonon_github/model/repository.dart';

class GithubRepository {
  final String _apiKey = "<PLACE TOKEN HERE>";

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Repository>> fetchRepositoryList(String username) async {
    final response = await _helper.get(username, _apiKey);
    return RepositoryResponse.fromJson(response).items;
  }
}
