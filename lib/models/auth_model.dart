import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
    ]);
    
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 2));

      final body = {
          'username': email,
          'password': password
      };

      var url = Uri.parse('https://f558-103-129-95-103.ngrok-free.app/auth/login');
      var response = await http.post(
        url, 
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _saveToken(data['data']['token']);

        _isLoading = false;
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _isLoading = false;
        _errorMessage = 'Invalid email or password';
        _isAuthenticated = false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveToken(token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      throw Exception('Failed to save token!');
    }
  }
}
