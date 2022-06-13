class ApiUrl {
  //MARK: get the base url
  String getBaseUrl() {
    var baseTestUrl = "https://api.github.com/search/";
    var baseLiveUrl = "https://api.github.com/search/";
    const bool _kReleaseMode = bool.fromEnvironment("dart.vm.product");
    return _kReleaseMode ? baseTestUrl : baseLiveUrl;
  }

  //MARK: url  to fetch repos
  String getRepositoryUrl(String username) {
    return getBaseUrl() + 'users?q="$username"';
  }
}
