import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/colors.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final bool isLoading;

  const LoginButton({
    super.key, 
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: AppColor.primary,
          ),
          child: Center(
            child: !isLoading
              ? const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                    fontSize: 13
                  ),
                )
              : const SpinKitCircle(
                  size: 30,
                  color: AppColor.white,
                )
          ),
        ),
      ),
    );
  }
}