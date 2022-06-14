class Repository {
  final String login;
  final String avatar;
  final double score;

  Repository(this.login, this.avatar, this.score);

  Repository.fromJson(Map<String, dynamic> json)
      : login = getJsonData(json, "login"),
        score = json["score"],
        avatar = getJsonData(json, "avatar_url");

  Map<String, dynamic> toJson() => {
        'login': login,
        'score': score,
        'avatar_url': avatar,
      };

  static String getJsonData(dynamic data, String key) {
    if (data == null || data[key] == null) {
      return "";
    }
    return data[key].toString();
  }
}

class RepositoryResponse {
  int totalCount = 0;
  bool incompleteResults = false;
  List<Repository> items = [];

  RepositoryResponse(this.totalCount, this.incompleteResults, this.items);

  RepositoryResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <Repository>[];
      json['items'].forEach((v) {
        items.add(Repository.fromJson(v));
      });
    }
  }
}
