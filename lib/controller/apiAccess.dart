import 'dart:convert';

import 'package:http/http.dart' as http;

String apiDomain = 'http://192.168.35.180/';

Future <Map<String, dynamic>> passwordAnalysis (String password) async {
  String apiUrl = apiDomain + 'check_password?password=' + Uri.encodeComponent('$password');
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> messageAnalysis (String message) async {
  String apiUrl = apiDomain + 'check_sms?phone=19981450917&sms=' + Uri.encodeComponent('$message');
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> callAnalysis (String phone) async {
  String apiUrl = apiDomain + 'check_number?phone=$phone';
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> urlAnalysis (String url) async {
  String apiUrl = apiDomain + 'check_url?url=' + Uri.encodeComponent('$url');
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}