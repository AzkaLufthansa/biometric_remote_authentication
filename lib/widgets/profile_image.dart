import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 45.0,
          sigmaY: 45.0
        ),
        child: Container(
          padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
            border: Border.all(color: AppColor.lightPrimary)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              GestureDetector(
                onTap: () {},
                onLongPress: () {},
                child: Stack(
                  children: [
                    Hero(
                      tag: 'profile-page-image',
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.width * 0.30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/img_default_picture.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ),
                    
                    // Edit Profile Picture Button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(AppDimen.marginPaddingSmallXX),
                        decoration: const BoxDecoration(
                          color: AppColor.lightPrimary,
                          shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.edit, color: AppColor.primary, size: 20,),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: AppDimen.marginPaddingMedium,),

              // User Name
              Text(
                'Dummy app!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppDimen.marginPaddingSmallX,),

              // User Last Login
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Terakhir login - ',
                      style: TextStyle(
                        color: AppColor.lightGrey3,
                        fontSize: 11
                      )
                    ),
                    TextSpan(
                      text: '',
                      style: const TextStyle(
                        color: AppColor.black,
                        fontSize: 11
                      ),
                    )
                  ]
                ),
                textAlign: TextAlign.center,
              )
            ],
          )
        ),
      ),
    );
  }
}