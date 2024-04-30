import 'dart:convert';

import 'package:http/http.dart' as http;

Future <Map<String, dynamic>> passwordAnalysis (String password) async {
  String apiUrl = 'http://localhost:8000/check_password?password=$password';
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> messageAnalysis (String message) async {
  String apiUrl = 'http://localhost:8000/check_sms?phone=19981450917&sms=$message';
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> callAnalysis (String phone) async {
  String apiUrl = 'http://localhost:8000/check_number?phone=$phone';
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}

Future <Map<String, dynamic>> urlAnalysis (String url) async {
  String apiUrl = 'http://localhost:8000/check_url?url=$url';
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = json.decode(utf8.decode(response.bodyBytes));

  return resultado;
}