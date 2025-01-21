import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class MainBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onChanged;

  const MainBottomBar({
    super.key, 
    required this.currentIndex, 
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimen.marginPaddingSmall,
        // horizontal: AppDimen.marginPaddingSmallX
      ),
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(
          AppDimen.radiusExtraLarge
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 0.5),
            blurRadius: 0.2,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            // color: AppColor.lightGrey3,
            child: Row(
              children: [
                InkWell(
                  onTap: () => onChanged(0),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
                    // color: AppColor.secondary,
                    child: Image.asset(
                      width: 25,
                      currentIndex == 0
                        ? 'assets/images/icon/ic_home_active.png'
                        : 'assets/images/icon/ic_home.png'
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => onChanged(1),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
                    // color: AppColor.secondary,
                    child: Image.asset(
                      width: 23,
                      currentIndex == 1
                        ? 'assets/images/icon/ic_history_active.png'
                        : 'assets/images/icon/ic_history.png'
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimen.marginPaddingSmall),
              padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary
              ),
              child: Image.asset(
                width: 25,
                currentIndex == 1
                  ? 'assets/images/icon/ic_add.png'
                  : 'assets/images/icon/ic_add.png'
              ),
            ),
          ),
          SizedBox(
            // color: AppColor.lightGrey3,
            child: Row(
              children: [
                InkWell(
                  onTap: () => onChanged(2),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
                    // color: AppColor.secondary,
                    child: Image.asset(
                      width: 25,
                      currentIndex == 2
                        ? 'assets/images/icon/ic_member_active.png'
                        : 'assets/images/icon/ic_member.png'
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => onChanged(3),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: currentIndex == 3
                          ? AppColor.primary
                          : AppColor.lightGrey3,
                        shape: BoxShape.circle,
                      ), 
                      child: const Icon(
                        Icons.person, 
                        color: AppColor.lightGrey2, 
                        size: 21,
                      ),
                    )
                  )
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}