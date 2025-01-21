import 'package:flutter/material.dart';

import '../utils/dimens.dart';

class LoginLogoTitle extends StatelessWidget {
  const LoginLogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimen.marginPaddingSmall,
        horizontal: AppDimen.marginPaddingMedium
      ),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        color: Colors.transparent
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/icon/ic_4vm_blue.png',
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}