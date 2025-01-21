import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  bool _isPasswordVerified = false;
  bool _isEnrollingLoading = false;
  String? _errorMessage;
  bool _isSuccessEnrolling = false;
  String? _enrollMessage;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isPasswordVerified => _isPasswordVerified;
  bool get isEnrollingLoading => _isEnrollingLoading;

  String? get enrollMessage => _enrollMessage;
  bool get isSuccessEnrolling => _isSuccessEnrolling;

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

  Future<void> verifyPassword(String email, String password) async {
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

      // Get token
      final token = await _getToken();

      var url = Uri.parse('https://f558-103-129-95-103.ngrok-free.app/auth/verify_password');
      var response = await http.post(
        url, 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        _isLoading = false;
        _isPasswordVerified = true;
        _errorMessage = null;
      } else {
        _isLoading = false;
        _errorMessage = 'Invalid email or password';
        _isPasswordVerified = false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      _isPasswordVerified = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> activateBiometric(String publicKey) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
    ]);
    
    _isEnrollingLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 2));

      final body = {
          'publicKey': publicKey,
      };

      // Get token
      final token = await _getToken();

      // TODO: Get User ID
      var url = Uri.parse('https://f558-103-129-95-103.ngrok-free.app/auth/activateBiometric/5');
      var response = await http.post(
        url, 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        _isEnrollingLoading = false;
        _isSuccessEnrolling = true;
        _enrollMessage = null;
      } else {
        _isEnrollingLoading = false;
        _enrollMessage = 'Invalid email or password';
        _isPasswordVerified = false;
      }
    } catch (e) {
      _enrollMessage = 'An error occurred: $e';
      _isSuccessEnrolling = false;
    } finally {
      _isEnrollingLoading = false;
      notifyListeners();
    }
  }

  Future<String?> _getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    } catch (e) {
      throw Exception('Failed to save token!');
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
