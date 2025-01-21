import 'dart:io';

import 'package:flutter/material.dart';

import 'login_page.dart';
import 'utils/colors.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.primary,
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppColor.primary,
          secondary: AppColor.lightPrimary,
        ),
      ),
      home: LoginPage(),
      
    );
  }
}