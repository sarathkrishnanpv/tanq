import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/auth/registration/otp_screen.dart';
import 'package:tanq.driver.app/screens/auth/registration/terms_conditions.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/widgets/back_button.dart';
import 'package:tanq.driver.app/widgets/custom_checkbox.dart';
import 'package:tanq.driver.app/widgets/custom_textfield.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/global.dart';
import '../../../../utils/reusablespacing.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _isChecked = false;
  bool _isChecked2 = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackArrowButton(),
                      AppStyles().semiBold(
                        text: "Create your account ",
                        size: 20,
                        color: AppColors.backgroundColor,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Threeh(),
                  CustomTextfield(
                    controller: name,
                    label: "NAME",
                    keyboardType: TextInputType.number,
                  ),
                  AppStyles().reg(text: "Name as on government ID's", size: 12),
                  const Threeh(),
                  CustomTextfield(
                    maxLength: 10,
                    controller: mobile,
                    label: "MOBILE NUMBER",
                    keyboardType: TextInputType.number,
                  ),
                  const Fiveh(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCheckbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                      const Twow(),
                      Flexible(
                        child: AppStyles().reg(
                          text:
                              'Get exclusive offers and updates on whatsapp your data is always safe and secure with us',
                          size: 12,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  const Oneh(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCheckbox(
                        value: _isChecked2,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked2 = value ?? false;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                      const Twow(),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I Accept all the ',
                                style: AppStyles()
                                    .reg(
                                      text: "",
                                      size: 12,
                                    )
                                    .style,
                              ),
                              TextSpan(
                                text: 'terms and conditions',
                                style: AppStyles()
                                    .med(
                                      text: "",
                                      size: 12,
                                      color: AppColors.blue,
                                      decoration: TextDecoration.underline,
                                    )
                                    .style,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle terms and conditions tap
                                    Get.to(
                                        () => const TermsAndConditionsScreen());
                                  },
                              ),
                              TextSpan(
                                style: AppStyles()
                                    .reg(
                                      text: "",
                                      size: 12,
                                    )
                                    .style,
                                text: ' of tanQ',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Threeh(),
                  AppButton(
                      onTap: () {
                        if (mobile.text.length < 10) {
                          errormsg("Enter a Valid Phone Number");
                        } else {
                          Get.to(() => const OtpScreen());
                        }
                      },
                      text: "Continue",
                      iconData: SvgPicture.asset(
                        Assets.images.icons.arrow,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
