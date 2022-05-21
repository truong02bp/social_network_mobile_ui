
class ApiModel<T> {
  String url;
  Map<String, String>? params;
  dynamic body;
  T Function(dynamic data)? parse;
  Map<String, String>? headers;

  ApiModel({required this.url, this.params, this.body, this.parse, this.headers});
}