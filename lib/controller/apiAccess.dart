import 'dart:convert';

import 'package:http/http.dart' as http;

String apiDomain = 'https://sherlock-f4n3.onrender.com/';

Future<Map<String, dynamic>> passwordAnalysis(String password) async {
  String apiUrl = apiDomain + 'check_password';
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'password': password}),
  );
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future<Map<String, dynamic>> messageAnalysis(String message) async {
  String apiUrl = apiDomain + 'check_sms';
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'sms': message}),
  );
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> appAnalysis (String checkApp) async {
  String apiUrl = apiDomain + 'check_app';
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'app': checkApp}),
  );
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future<Map<String, dynamic>> urlAnalysis(String url) async {
  String apiUrl = apiDomain + 'check_url';
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'url': url}),
  );
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future<Map<String, dynamic>> fakenewsAnalysis(String news) async {
  String apiUrl = apiDomain + 'check_news';
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'news': news}),
  );
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}
