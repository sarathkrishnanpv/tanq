import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/domain/methods_and_calls.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/main_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/personal_info_screen.dart';
import 'package:tanq.driver.app/screens/tab/tab_section.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';
import 'package:tanq.driver.app/widgets/back_button.dart';

import 'package:pinput/pinput.dart';

class AddMpin extends StatefulWidget {
  const AddMpin({super.key});

  @override
  State<AddMpin> createState() => _AddMpinState();
}

class _AddMpinState extends State<AddMpin> {
  final pinController = TextEditingController();

  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Assets.images.icons.bug,
      'text': 'Bug Report',
    },
    {
      'icon': Assets.images.icons.report,
      'text': 'Report a problem',
    },
    {
      'icon': Assets.images.icons.privacy,
      'text': 'Privacy terms',
    },
    {
      'icon': Assets.images.icons.help,
      'text': 'Help',
    }
  ];
  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      margin: EdgeInsets.all(2),
      width: 30,
      height: 50,
      textStyle: TextStyle(fontSize: 20, color: Colors.black),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Container(
            height: Constants.height * 0.25,
            width: Constants.width,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                     Assets.images.normal.loginBackground.path,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackArrowButton(),
                    AppStyles().semiBold(
                      text: "Enter your M-PIN ",
                      size: 20,
                      color: AppColors.backgroundColor,
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Pinput(
                          autofocus: true,
                          controller: pinController,
                          focusNode: focusNode,
                          length: 4,
                          defaultPinTheme: defaultPinTheme,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          obscureText: false,
                          onCompleted: (pin) {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Sevenh(),
                AppButton(
                    onTap: () {
                      // Navigate to the first questionnaire screen
                      Get.offNamed('/questionnaire/personal');
                    },
                    text: "Continue",
                    icon: true,
                    iconData: SvgPicture.asset(
                      Assets.images.icons.arrow,  
                    )),
                const Twoh(),
                AppStyles().reg(
                  textAlign: TextAlign.center,
                  text: "You can use this code the next time you \nlog in",
                  size: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
