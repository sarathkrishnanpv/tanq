import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/order_screens/order_details.dart';
import 'package:tanq.driver.app/screens/tanq_shop/shop_screen/shop_home.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';


class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            Assets.images.normal.logo.path,
            color: AppColors.black,
            width: Constants.width * .3,
            height: Constants.height * .2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.images.normal.banner.path,
                //success
                height: Constants.height * 0.1,
                width: Constants.width * 0.4,
              ),
              AppStyles ().semiBold(
                textAlign: TextAlign.center,
                color: AppColors.green,
                text: "Your order placed\n successfully",
                size: 18,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                AppButton(
                  onTap: () {
                    Get.to(() => const ShopHome());
                  },
                  text: "Done",
                  iconData: const SizedBox(),
                ),
                const Oneh(),
                AppButton(
                  onTap: () {
                    Get.to(() => OrderDetails());
                  },
                  buttonColor: AppColors.grey,
                  textColor: AppColors.black,
                  text: "View Order",
                  iconData: SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
