import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import 'package:carousel_slider/carousel_controller.dart' as car;
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/product_detail/product_detail.dart';
import 'package:tanq.driver.app/screens/tanq_shop/shop_screen/shop_home.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final car.CarouselSliderController carouselController =
      car.CarouselSliderController();

  int carouselIndex = 0;
  List offerbanner = [
    Assets.images.normal.banner1.path,
    Assets.images.normal.banner1.path,
    Assets.images.normal.banner1.path,
  ];
  List products = [
    Assets.images.normal.iphone.path,
    Assets.images.normal.product1.path,
    Assets.images.normal.product2.path,
    Assets.images.normal.product3.path,
    Assets.images.normal.product4.path,
    Assets.images.normal.product5.path,
  ];
  List category = [
    "Smart Phone",
    "Laptops",
    "Headphones",
    "Watches",
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        leadingWidth: 55,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              Assets.images.icons.backShop.path,
              fit: BoxFit.fill,
              height: 40,
            ),
          ),
        ),
        actions: [
          SvgPicture.asset(Assets.images.icons.cart),
          const Fivew(),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppStyles().semiBold(text: "Electronics", size: 22),
                SvgPicture.asset(Assets.images.icons.sideMenu),
              ],
            ),
            const Twoh(), 
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(category.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? AppColors.black
                                : AppColors.backgroundColor,
                            border: Border.all(color: AppColors.black)),
                        child: AppStyles().med(
                            text: category[index],
                            size: 12,
                            color: selectedIndex == index
                                ? AppColors.backgroundColor
                                : AppColors.black),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: AppColors.grey,
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(2)),
              child: TextFormField(
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black.withOpacity(0.8),
                  fontSize: 12,
                  fontFamily: "Lato",
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.grey,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.grey,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.black,
                  ),
                  hintText: "Search Products",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w200,
                    color: AppColors.black,
                    fontSize: 12,
                    fontFamily: "Lato",
                  ),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.grey,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const Threeh(),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    height: Constants.height * 0.15,
                    child: Image.asset(
                      offerbanner[index],
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
                offerbanner.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 7,
                  height: 7,
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
