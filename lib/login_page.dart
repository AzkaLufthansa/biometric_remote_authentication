import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';
import 'models/auth_model.dart';
import 'utils/colors.dart';
import 'utils/dimens.dart';
import 'widgets/login_button.dart';
import 'widgets/login_logo_title.dart';
import 'widgets/text_field_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyAppState();
}

class _MyAppState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: 'user');
  final TextEditingController _passwordController = TextEditingController(text: '12345678');

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthModel(),
      child: _content(context)
    );
  }

  Scaffold _content(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColor.white,
    body: Consumer<AuthModel>(
      builder: (context, model, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Background
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/bg/bg_login_red.png',
                fit: BoxFit.fill,
              ),
            ),


            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo Title
                    const LoginLogoTitle(),

                    Flexible(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              child: Column(
                                children: [
                                  Text(
                                    'Login ke akun\nAnda',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppDimen.marginPaddingMedium),

                            const SizedBox(
                              child: Text(
                                'Masukan akun Anda disini',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.lightGrey3,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                                  
                            const SizedBox(height: 50,),

                            // Email Textfield
                            TextFieldLogin(
                              focusNode: _emailFocusNode,
                              controller: _emailController,
                              label: 'Email',
                              textInputAction: TextInputAction.next,
                              hintText: 'Email',
                              icon: 'assets/images/icon/ic_username.png',
                            ),
                      
                            const SizedBox(height: AppDimen.marginPaddingSmall),
                            
                            // Password Textfield
                            TextFieldLogin(
                              focusNode: _passwordFocusNode,
                              controller: _passwordController,
                              label: 'Password',
                              textInputAction: TextInputAction.send,
                              hintText: 'Password',
                              onFieldSubmitted: (value) async {
                                // To prevent multiple click
                                if (!model.isLoading) {
                                  _emailFocusNode.unfocus();
                                  _passwordFocusNode.unfocus();
              
                                  await model.login(
                                    _emailController.text, 
                                    _passwordController.text
                                  );

                                  if (model.isAuthenticated) {
                                     // Navigate to Main Page
                                     Navigator.pushReplacement(
                                       // ignore: use_build_context_synchronously
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => MainPage(),
                                       ),
                                     );
                                  } else {
                                    Fluttertoast.showToast(msg: 'Login failed! ${model.errorMessage}');
                                  }
                                }
                              },
                              icon: 'assets/images/icon/ic_password.png',
                              isPassword: true,
                              obscureText: _isObscure,
                              togglePassword: () => setState(() => _isObscure = !_isObscure),
                            ),

                            const SizedBox(height: AppDimen.marginPaddingSmall,),

                            Text(
                              'dummy app',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColor.lightGrey3
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Button
                    LoginButton(
                      onTap: () async {
                        // To prevent multiple click
                        if (!model.isLoading) {
                          _emailFocusNode.unfocus();
                          _passwordFocusNode.unfocus();
      
                          await model.login(
                            _emailController.text, 
                            _passwordController.text
                          );

                          if (model.isAuthenticated) {
                              // Navigate to Main Page
                              Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                              );
                          } else {
                            Fluttertoast.showToast(msg: 'Login failed! ${model.errorMessage}');
                          }
                        }
                      },
                      isLoading: model.isAuthenticated,
                    ),
                  ],
                ),
              ),
            ),

            model.isLoading
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.black26
                  ),
                )
              : const SizedBox(),

            model.isLoading
              ? Center(
                  child: Container(
                    width: 100,
                    height: 100,
                      padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
                      ),
                      child: Center(
                        child: SpinKitCircle(
                          size: 30,
                          color: AppColor.primary,
                        ),
                      )
                    ),
                )
              : const SizedBox()
          ],
        );
      }
    )
  );
  }
}