import 'dart:convert';

import 'package:http/http.dart' as http;

Future <Map<String, dynamic>> passwordAnalysis (String password) async {
  String apiUrl = 'http://localhost:8000/check_password?password=$password';
  var response = await http.post(Uri.parse(apiUrl));
  var resultado = jsonDecode(response.body);

  return resultado;
}