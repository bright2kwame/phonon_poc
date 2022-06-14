import 'dart:async';
import 'package:phonon_github/api/api_response.dart';
import 'package:phonon_github/api/github_repository.dart';
import 'package:phonon_github/model/repository.dart';

class RepositoryBloc {
  late GithubRepository _githubRepository;
  late StreamController<ApiResponse<List<Repository>>> _repoController;

  StreamSink<ApiResponse<List<Repository>>> get githubRepoSink =>
      _repoController.sink;

  Stream<ApiResponse<List<Repository>>> get githubRepoStream =>
      _repoController.stream;

  RepositoryBloc(String username) {
    _repoController = StreamController<ApiResponse<List<Repository>>>();
    _githubRepository = GithubRepository();
    fetchRepositories(username);
  }

  fetchRepositories(String username) async {
    githubRepoSink.add(ApiResponse.loading('Fetching repositories'));
    try {
      List<Repository> repositories =
          await _githubRepository.fetchRepositoryList(username);
      githubRepoSink.add(ApiResponse.completed(repositories));
    } catch (e) {
      githubRepoSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _repoController.close();
  }
}
