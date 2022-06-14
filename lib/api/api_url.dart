class ApiUrl {
  //MARK: get the base url
  String getBaseUrl() {
    var baseTestUrl = "https://api.github.com/";
    var baseLiveUrl = "https://api.github.com/";
    const bool _kReleaseMode = bool.fromEnvironment("dart.vm.product");
    return _kReleaseMode ? baseTestUrl : baseLiveUrl;
  }

  //MARK: url  to fetch repos
  String getRepositoryUrl(String username) {
    return getBaseUrl() + 'search/users?q="$username"';
  }
}
