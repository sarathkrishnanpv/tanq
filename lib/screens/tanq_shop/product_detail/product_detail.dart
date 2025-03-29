import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/cart/cart_screen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/shop_screen/shop_home.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/app_images.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';
import 'package:tanq.driver.app/widgets/full_screen.dart';

import 'package:carousel_slider/carousel_controller.dart' as car;


class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final car.CarouselSliderController carouselController =
      car.CarouselSliderController();
  List banner1 = [
    Assets.images.normal.bannerHome.path,
    Assets.images.normal.banner1.path,
  ];
  int carouselIndex2 = 0;
  bool expand = false;
  bool expand1 = false;
  List banner = [
    Assets.images.normal.iphone.path,
    Assets.images.normal.iphone.path,
    Assets.images.normal.iphone.path,
  ];
  List products = [
    Assets.images.normal.iphone.path,
    Assets.images.normal.product1.path,
    Assets.images.normal.product2.path,
    Assets.images.normal.product3.path,
    Assets.images.normal.product4.path,
    Assets.images.normal.product5.path,
  ];
  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '₹', decimalDigits: 2);

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: Constants.height * 0.13,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 5,
              color: const Color(0xFF666569).withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppButton(
                onTap: () {},
                textColor: AppColors.black,
                text: "Add to Cart",
                buttonColor: AppColors.grey,
                iconData: Container(),
              ),
            ),
            const Twow(),
            Expanded(
              child: AppButton(
                onTap: () {
                  Get.to(() => CartScreen());
                },
                text: "Buy Instantly",
                iconData: SvgPicture.asset(Assets.images.icons.arrow),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.grey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            Assets.images.icons.backShop.path,
                            fit: BoxFit.fill,
                            height: 25,
                          ),
                        ),
                        SvgPicture.asset(Assets.images.icons.cart),
                      ],
                    ),
                    const Twoh(),
                    _buildOfferBanner(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles().reg(
                      text: 'Apple',
                      size: 14,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    const Twoh(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles().semiBold(
                          text: 'iPhone Mobile 16 (128GB ROM)',
                          size: 18,
                        ),
                        const Oneh(),
                        Row(
                          children: [
                            Flexible(
                              child: AppStyles().semiBold(
                                text: currencyFormat.format(69190.00),
                                size: 12,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            const Twow(),
                            Flexible(
                              child: AppStyles().reg(
                                text: currencyFormat.format(11934.00),
                                size: 12,
                                overflow: TextOverflow.visible,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const Twow(),
                            AppStyles().semiBold(
                              text: '12% off',
                              size: 14,
                              color: AppColors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ExpansionTile(
                        onExpansionChanged: (value) {
                          setState(() {
                            expand = value;
                          });
                        },
                        trailing:
                            Icon(expand ? Icons.minimize_outlined : Icons.add),
                        initiallyExpanded: false,
                        tilePadding: EdgeInsets.zero,
                        expandedAlignment: Alignment.topLeft,
                        enableFeedback: false,
                        title: AppStyles().med(
                          text: "Product Details",
                          size: 14,
                        ),
                        shape:
                            const BeveledRectangleBorder(side: BorderSide.none),
                        children: [
                          AppStyles().med(
                            text: "Product Details",
                            size: 14,
                            color: AppColors.black.withOpacity(.8),
                          ),
                        ]),
                    const Divider(),
                    ExpansionTile(
                        onExpansionChanged: (value) {
                          setState(() {
                            expand1 = value;
                          });
                        },
                        trailing:
                            Icon(expand1 ? Icons.minimize_outlined : Icons.add),
                        childrenPadding: EdgeInsets.zero,
                        initiallyExpanded: false,
                        tilePadding: EdgeInsets.zero,
                        expandedAlignment: Alignment.topLeft,
                        enableFeedback: false,
                        title: AppStyles().med(
                          text: "Product Details",
                          size: 14,
                        ),
                        shape:
                            const BeveledRectangleBorder(side: BorderSide.none),
                        children: [
                          AppStyles().med(
                            text: "Product Description",
                            size: 12,
                            color: AppColors.black.withOpacity(.8),
                          ),
                        ]),
                    const Fiveh(),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .58,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.to(() => const ProductDetail());
                              },
                              child: ProductCard (
                                index: index,
                                products: products,
                              ));
                        }),
                    const Oneh(),
                    _buildBanner(),
                    const Fiveh(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildBanner() {
    return SizedBox(
      // color: AppColors.red,
      width: Constants.width,
      height: Constants.height * 0.2,
      child: Column(
        children: [
          CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: banner1.length,
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
                      banner1[index],
                      fit: BoxFit.fill,
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
                banner1.length,
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

  SizedBox _buildOfferBanner() {
    return SizedBox(
      // color: AppColors.red,
      width: Constants.width,
      height: Constants.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: banner.length,
              options: CarouselOptions(
                height: Constants.height * 0.35,
                viewportFraction: 1,
                enlargeCenterPage: true,
                padEnds: false,
                enlargeFactor: 0.5,
                autoPlay: false,
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
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imagePath: banner[index],
                          tag: 'carouselImage$index',
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'carouselImage$index',
                    child: SizedBox(
                      width: Constants.width,
                      height: Constants.height * 0.35,
                      child: Image.asset(
                        banner[index],
                        fit: BoxFit.contain,
                      ),
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
          const Twoh(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banner.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: index == carouselIndex2
                        ? Colors.black
                        : Colors.grey.shade400,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
