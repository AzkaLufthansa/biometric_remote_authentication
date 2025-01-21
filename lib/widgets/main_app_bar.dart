import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  final Function() onTapBack;
  final IconData? actionIcon;

  const MainAppBar({
    super.key, 
    required this.title, 
    required this.onTapBack,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => onTapBack(),
          child: Container(
            padding: const EdgeInsets.all(AppDimen.marginPaddingSmallX),
            decoration: const BoxDecoration(
              color: AppColor.black,
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.arrow_back, color: AppColor.white, size: 20,),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimen.marginPaddingSmall),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),

        Opacity(
          opacity: 0.0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(AppDimen.marginPaddingSmallX),
              child: Icon(actionIcon ?? Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }
}