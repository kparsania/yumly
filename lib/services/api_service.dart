import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String _baseUrl = 'https://foodloverapp.herokuapp.com/api/v1';
  static const String _baseUrl = 'https://api.spoonacular.com';

  static Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    try {
      print('Request url:: $_baseUrl$endpoint');
      final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: {
        ...?queryParams,
        'apiKey': '69f8df38d9eb4b9f99568098b1fae553',
      });
      final response = await http.get(uri, headers: headers ?? _defaultHeaders);

      if (response.statusCode == 200) {
        print("response::: ${response.statusCode} ::: ${response.body}" );
        return jsonDecode(response.body);
        
      } else {
        throw Exception('GET ${uri.path} failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('GET error: $e');
    }
  }

  static Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.post(
        uri,
        headers: headers ?? _defaultHeaders,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('POST ${uri.path} failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('POST error: $e');
    }
  }

  static Map<String, String> get _defaultHeaders => {
    'Content-Type': 'state/json',
    'Accept': 'state/json',
    // Add your auth token here if needed
  };
}
