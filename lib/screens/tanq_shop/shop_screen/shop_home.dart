import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import 'package:carousel_slider/carousel_controller.dart' as car;

import 'package:intl/intl.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/models/ride_type.dart';
import 'package:tanq.driver.app/screens/tanq_shop/cart/cart_screen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/category_screen/category_screen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/product_detail/product_detail.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  final car.CarouselSliderController carouselController =
      car.CarouselSliderController();

  int carouselIndex = 0;
  int carouselIndex2 = 0;
  List banner = [
    Assets.images.normal.banner1.path,
    Assets.images.normal.banner.path,
  ];
  List offerbanner = [
    Assets.images.normal.bannerHome.path,
    Assets.images.normal.banner1.path,
    Assets.images.normal.bannerHome.path,
  ];
  List products = [
    Assets.images.normal.iphone.path,
    Assets.images.normal.product1.path,
    Assets.images.normal.product2.path,
    Assets.images.normal.product3.path,
    Assets.images.normal.product4.path,
    Assets.images.normal.product5.path,
  ];
  List<RecentLocation> cat = [
    RecentLocation(name: "Electronics", location: Assets.images.icons.category.path),
    RecentLocation(
      name: "Vehicle GPS",
      location: Assets.images.normal.cat1.path,
    ),
    RecentLocation(name: "Fashion", location: Assets.images.normal.cat2.path),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              Assets.images.icons.backShop.path,
              fit: BoxFit.fill,
              height: 30,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.images.icons.brandPng.path),
            SvgPicture.asset(Assets.images.icons.brandSvg),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => CartScreen());
              },
              child: SvgPicture.asset(Assets.images.icons.cart)),
          const Twow(),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Twoh(),
            _buildBanner(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Twoh(),
                  SvgPicture.asset(Assets.images.icons.trending),
                  const Oneh(),
                  AppStyles().reg(
                      text: "Get up to 59% off selected GPS products.",
                      size: 12),
                  const Twoh(),
                  SizedBox(
                    height: Constants.height * 0.21,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cat.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.to(() => const CategoryScreen());
                              },
                              child: categoryMain(index));
                        }),
                  ),
                  const Threeh(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppStyles().med(text: "Trending Products ", size: 16),
                      AppStyles().semiBold(text: "See All ", size: 12),
                    ],
                  ),
                  const Twoh(),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .57,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => const ProductDetail());
                            },
                            child: ProductCard(
                              index: index,
                              products: products,
                            ));
                      }),
                  const Oneh(),
                  _buildOfferBanner(),
                  const Sevenh(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryMain(int index) {
    Random random = Random();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(2),
          width: Constants.width * 0.28,
          height: Constants.height * 0.23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.width * 0.2),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                AppColors.yellow.withOpacity(0.08),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.amber),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    cat[index].location,
                    fit: BoxFit.fill,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              AppStyles().semiBold(
                text: cat[index].name,
                size: 14,
                color: AppColors.brown,
              ),
            ],
          ),
        ),
        // Generate 2-3 randomly positioned stars
        ...List.generate(random.nextInt(1) + 2, (i) {
          return Positioned(
            left: random.nextDouble() * (Constants.width * 0.28 - 10),
            top: random.nextDouble() * (Constants.height * 0.23 - 20),
            child: Image.asset(
              Assets.images.icons.starImage.path,
              width: 45,
              height: 45,
              // Optional: add slight color tint
            ),
          );
        }),
      ],
    );
  }

  SizedBox _buildOfferBanner() {
    return SizedBox(
      width: Constants.width,
      height: Constants.height * 0.2,
      child: Column(
        children: [
          CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: offerbanner.length,
              options: CarouselOptions(
                height: Constants.height * 0.15,
                viewportFraction: 1,
                enlargeCenterPage: true,
                padEnds: false,
                enlargeFactor: 0.5,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.decelerate,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        carouselIndex2 = index;
                      });
                    }
                  });
                },
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () async {},
                  child: SizedBox(
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 15, vertical: 10),
                    width: Constants.width,
                    height: Constants.height * 0.15,
                    child: Image.asset(
                      offerbanner[index],
                      fit: BoxFit.cover,
                    ),
                    // CachedNetworkImage(
                    //   imageUrl: controller.userHomeDetails["banner_data"][index]
                    //           ["image"] ??
                    //       "",
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                  ),
                );
              }),
          const Oneh(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                offerbanner.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: index == carouselIndex2
                        ? Colors.black
                        : Colors.grey.shade400,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox _buildBanner() {
    return SizedBox(
      // color: AppColors.red,
      width: Constants.width,
      height: Constants.height * 0.35,
      child: Column(
        children: [
          CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: banner.length,
              options: CarouselOptions(
                height: Constants.height * 0.3,
                viewportFraction: 1,
                enlargeCenterPage: true,
                padEnds: false,
                enlargeFactor: 0.5,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.decelerate,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        carouselIndex = index;
                      });
                    }
                  });
                },
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () async {},
                  child: SizedBox(
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 15, vertical: 10),
                    width: Constants.width,
                    height: Constants.height * 0.3,
                    child: Image.asset(
                      banner[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  //     CachedNetworkImage(
                  //   width: Constants.width,
                  //   height: Constants.height * 0.4,
                  //   imageUrl: banner[index] ?? "",
                  //   errorWidget: (context, url, error) =>
                  //       const Icon(Icons.error),
                  // ),
                  // ),
                );
              }),
          const Oneh(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banner.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == carouselIndex
                        ? Colors.black
                        : Colors.grey.shade400,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.products,
    required this.index,
  });
  final List products;
  final int index;
  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '₹', decimalDigits: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.grey,
          ),
          child: Center(
            child: Image.asset(
              products[index],
              width: Constants.width * 0.34,
              height: Constants.height * 0.17,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppStyles().reg(
            text: 'Apple',
            size: 12,
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles().semiBold(
                text: 'iPhone Mobile 16 (128GB ROM)',
                size: 13,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Oneh(),
              Row(
                children: [
                  Flexible(
                    child: AppStyles().reg(
                      text: currencyFormat.format(69190.00),
                      size: 12,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const Onew(),
                  Flexible(
                    child: AppStyles().reg(
                      text: currencyFormat.format(11934.00),
                      size: 12,
                      color: AppColors.black.withOpacity(0.3),
                      overflow: TextOverflow.visible,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              AppStyles().semiBold(
                text: '12% off',
                size: 14,
                color: AppColors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
