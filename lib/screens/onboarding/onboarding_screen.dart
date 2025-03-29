import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/auth/login_view.dart';
import 'package:tanq.driver.app/screens/auth/registration/create_account.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/app_images.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  double _progress = 0.0;
  late Timer _timer;
  final PageController _pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      "image": Assets.images.normal.onboard1.path,
      "title": "Seamless rides, effortless\npayments",
      "description": "Book a cab instantly or schedule\n your ride in advance"
    },
    {
      "image": Assets.images.normal.onboard2.path,
      "title": "Safe journeys, trusted\ndrivers",
      "description":
          "Every ride is backed by\nverified drivers and real-time tracking"
    },
    {
      "image": Assets.images.normal.onboard3.path,
      "title": "Seamless rides, effortless\npayments",
      "description": "Enjoy a hassle-free experience with\nquick bookings"
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.033;
        if (_progress >= 1.0) {
          _progress = 0.0;
          _currentIndex = (_currentIndex + 1) % onboardingData.length;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                _currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastEaseInToSlowEaseOut,
              );
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingData.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 30,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(3),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: index == _currentIndex ? 35 * _progress : 0,
                height: 6,
                decoration: BoxDecoration(
                  color: index == _currentIndex
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: Constants.height * 0.6,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onboardingData.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          onboardingData[index]["image"]!,
                          fit: BoxFit.cover,
                          width: Constants.width,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: _buildProgressIndicator(),
                  )
                ],
              ),
              Container(
                width: Constants.width,
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      duration: const Duration(milliseconds: 1200),
                      child: AppStyles().med(
                        key: ValueKey(_currentIndex),
                        text: onboardingData[_currentIndex]["title"]!,
                        textAlign: TextAlign.center,
                        size: 22,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      duration: const Duration(milliseconds: 1000),
                      child: AppStyles().reg(
                        key: ValueKey(_currentIndex),
                        text: onboardingData[_currentIndex]["description"]!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        size: 16,
                      ),
                    ),
                    const Twoh(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AppButton(
                    onTap: () {
                      Get.to(() => const CreateAccount(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 500));
                    },
                    text: "Create an account",
                    icon: true,
                    iconData: SvgPicture.asset(Assets.images.icons.arrow),
                  ),
                  AppButton(
                    onTap: () {
                      Get.to(() => const LoginView(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 500));
                    },
                    text: "Log in",
                    icon: false,
                    iconData: Container(),
                    textColor: AppColors.black,
                    buttonColor: AppColors.backgroundColor,
                  ),
                  const Fiveh(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
