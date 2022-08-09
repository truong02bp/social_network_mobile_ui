import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_mobile_ui/models/api_model.dart';

class ApiRepository {
  Future<dynamic> get<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.get(
          Uri.parse(model.url).replace(queryParameters: model.params),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      log("${model.url} ${exception.toString()}");
      return null;
    }
  }

  Future<dynamic> post<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null && !model.isLogin) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.post(
          Uri.parse(model.url).replace(queryParameters: model.params),
          body: jsonEncode(model.body),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      log("${model.url} ${exception.toString()}");
      return null;
    }
  }

  Future<dynamic> put<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.put(
          Uri.parse(model.url).replace(queryParameters: model.params),
          body: jsonEncode(model.body),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      log("${model.url} ${exception.toString()}");
      return null;
    }
  }

  Future<dynamic> delete<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.delete(
          Uri.parse(model.url).replace(queryParameters: model.params),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      log("${model.url} ${exception.toString()}");
      return null;
    }
  }

  dynamic parseResponse({res, model}) {
    if (res.statusCode == 200) {
      if (model.parse != null) {
        String data = Utf8Decoder().convert(res.bodyBytes);
        final jsonData = jsonDecode(data);
        return model.parse!(jsonData);
      }
      return res.body;
    } else {
      log("${model.url} ${res.statusCode}");
      return null;
    }
  }
}
