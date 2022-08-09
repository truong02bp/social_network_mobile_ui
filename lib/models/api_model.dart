class ApiModel<T> {
  String url;
  Map<String, String>? params;
  dynamic body;
  T Function(dynamic data)? parse;
  Map<String, String>? headers;
  bool isLogin = false;

  ApiModel(
      {required this.url, this.params, this.body, this.parse, this.headers});
}
