// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/auth_model.dart';
import 'utils/dimens.dart';
import 'widgets/main_app_bar.dart';
import 'widgets/profile_image.dart';
import 'widgets/security_setting.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onTapBack;

  const ProfilePage({
    super.key,
    required this.onTapBack,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthModel()..checkBiometric(),
      child: _content(context)
    );
  }

  Scaffold _content(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            padding: EdgeInsets.only(
              left: AppDimen.marginPaddingMedium,
              right: AppDimen.marginPaddingMedium,
              top: MediaQuery.of(context).padding.top + AppDimen.marginPaddingMedium,
              bottom: AppDimen.bottomNavbarHeight + AppDimen.marginPaddingMedium * 2
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainAppBar(
                  title: 'Profile',
                  onTapBack: widget.onTapBack,
                ),
                const SizedBox(height: AppDimen.marginPaddingLarge),
                
                const ProfileImage(),
                const SizedBox(height: AppDimen.marginPaddingLarge),

                const SecuritySetting(),
                const SizedBox(height: AppDimen.marginPaddingLarge)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
