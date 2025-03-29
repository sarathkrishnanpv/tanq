import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/widgets/back_button.dart';


class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: const BackArrowButton(),
        title: AppStyles().semiBold(
          text: "Terms and Conditions",
          size: 18,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("1. Acceptance of Terms",
                "By accessing and using the tanQ app, you agree to be bound by these Terms and Conditions."),
            _buildSection("2. User Registration",
                "Users must provide accurate and complete information during registration. You are responsible for maintaining the confidentiality of your account."),
            _buildSection("3. Service Usage",
                "Our services are provided 'as is'. We reserve the right to modify or discontinue services at any time."),
            _buildSection("4. Privacy Policy",
                "Your use of tanQ is also governed by our Privacy Policy, which can be found in the app."),
            _buildSection("5. User Conduct",
                "Users agree to use the service in compliance with all applicable laws and regulations."),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStyles().semiBold(
            text: title,
            size: 16,
          ),
          const SizedBox(height: 8),
          AppStyles().reg(
            text: content,
            size: 14,
          ),
        ],
      ),
    );
  }
}
