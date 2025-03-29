import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/models/ride_type.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';


class RecentSearchs extends StatelessWidget {
  const RecentSearchs({
    super.key,
    required this.recents,
  });

  final RecentLocation recents;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: AppColors.grey.withOpacity(0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.images.icons.recent,
                height: 27,
              ),
              const Twow(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles().semiBold(text: recents.name, size: 14),
                  AppStyles().reg(
                      text: recents.location,
                      size: 12,
                      color: AppColors.black.withOpacity(0.6)),
                ],
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: AppColors.black.withOpacity(0.3),
          )
        ],
      ),
    );
  }
}
