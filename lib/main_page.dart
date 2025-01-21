import 'package:flutter/material.dart';

import 'profile_page.dart';
import 'utils/colors.dart';
import 'utils/dimens.dart';
import 'widgets/main_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: [
              Scaffold(
                backgroundColor: AppColor.white,
                body: Center(
                  child: Text(
                    'Dummy app!'
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: AppColor.white,
                body: Center(
                  child: Text(
                    'Dummy app!'
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: AppColor.white,
                body: Center(
                  child: Text(
                    'Dummy app!'
                  ),
                ),
              ),
              ProfilePage(
                onTapBack: () {
                  _pageController.jumpTo(0);
                },
              )
            ],
          ),
    
          // Bottom Navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
              child: MainBottomBar(
                currentIndex: _currentIndex,
                onChanged: (index) {
                  _pageController.jumpToPage(index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
