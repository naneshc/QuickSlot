import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  String? _currentUserId;

  ApiClient({required this.baseUrl});

  void setUserId(String? userId) {
    _currentUserId = userId;
  }

  String? get currentUserId => _currentUserId;

  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (_currentUserId != null) {
      headers['X-User-Id'] = _currentUserId!;
    }
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    return headers;
  }

  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    return http.get(uri, headers: _buildHeaders(headers));
  }

  Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    return http.post(
      uri,
      headers: _buildHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    return http.delete(uri, headers: _buildHeaders(headers));
  }
}
