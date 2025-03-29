import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/models/ride_type.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';


class VehiclesCard extends StatelessWidget {
  const VehiclesCard({
    super.key,
    required this.suggestedRides,
  });
  final SuggestedRide suggestedRides;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: Constants.width * 0.43,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.asset(
              suggestedRides.image,
              height: Constants.height * 0.14,
              width: Constants.width,
              fit: BoxFit.cover,
            ),
          ),
          Halfh(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles().med(text: suggestedRides.name, size: 16),
                  SvgPicture.asset(
                    Assets.images.icons.arrow,
                    colorFilter: const ColorFilter.mode(
                        Color(0xff000000), BlendMode.srcIn),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AppStyles().med(
                text: suggestedRides.description,
                overflow: TextOverflow.visible,
                size: 12,
                color: AppColors.black.withOpacity(0.4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
