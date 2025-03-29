import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/tanq_shop/order_screens/order_details.dart';
import 'package:tanq.driver.app/screens/tanq_shop/order_screens/order_placed.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/app_images.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/custom_textfield.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';

import 'cart_controller.dart';
import '../../../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: Constants.height * 0.13,
        padding: const EdgeInsets.all(30),
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
        child: Obx(() {
          return AppButton(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: AppColors.backgroundColor,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: AddressBottomSheet(),
                  );
                },
              );
            },
            text: "Pay ${controller.formatPrice(controller.total)}",
            iconData: SvgPicture.asset(Assets.images.icons.arrow),
          );
        }),
      ),
      backgroundColor: Colors.white,
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
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles().med(text: "Upcoming Orders", size: 16),
              const Twoh(),
              ...List.generate(1, (index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => OrderDetails());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 1,
                            color: AppColors.grey,
                            spreadRadius: 1)
                      ],
                      border: Border.all(
                        color: AppColors.black.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: AppColors.grey,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    Assets.images.normal.iphone.path,
                                    width: Constants.width * 0.24,
                                    height: Constants.height * 0.1,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              const Threew(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppStyles().semiBold(
                                      text: "iPhone 12 Blur Titanium +3 ",
                                      size: 14),
                                  const Twoh(),
                                  AppStyles().med(
                                      text: "Total Payable Amount",
                                      size: 12,
                                      color: AppColors.black
                                          .withOpacity(0.4)),
                                  AppStyles().med(text: "69,000", size: 12),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Oneh(),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: AppColors.blue.withOpacity(0.09)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppStyles().med(
                                text: "Arriving 12 Nov 2024",
                                size: 14,
                                color: AppColors.blue,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: AppColors.blue,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              const Threeh(),
              AppStyles().semiBold(text: "Cart", size: 22),
              const Twoh(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return _buildCartItem(item);
                },
              ),
              const Twoh(),
              const Divider(),
              const Twoh(),
              _buildOrderSummary(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.grey,
            ),
            child: Center(
              child: Image.asset(
                Assets.images.normal.iphone.path,
                width: Constants.width * 0.34,
                height: Constants.height * 0.14,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles().reg(
                  text: item.brand,
                  size: 14,
                ),
                const Oneh(),
                AppStyles().semiBold(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: item.name,
                  size: 16,
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    AppStyles().reg(
                      text: controller.formatPrice(item.price),
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    if (item.originalPrice != null)
                      AppStyles().reg(
                          text: controller.formatPrice(item.originalPrice!),
                          size: 14,
                          decoration: TextDecoration.lineThrough),
                    const SizedBox(width: 8),
                    if (item.discountPercentage != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: AppStyles().reg(
                          text: '${item.discountPercentage}% off',
                          size: 12,
                          color: AppColors.green,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onPressed: () => controller.decrementQuantity(item),
                          ),
                          Container(
                            width: 40,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                horizontal:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            icon: Icons.add,
                            onPressed: () => controller.incrementQuantity(item),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppStyles().semiBold(
          text: 'Order Summary',
          size: 14,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: const BoxDecoration(color: AppColors.grey),
          child: Column(
            children: [
              _buildSummaryRow(
                'Cart Subtotal -',
                controller.formatPrice(controller.subtotal),
              ),
              const SizedBox(height: 8),
              _buildSummaryRow(
                'Discount on every products -',
                controller.formatPrice(controller.discount),
              ),
              const Twoh(),
              _buildSummaryRow(
                'Total Payable amount -',
                controller.formatPrice(controller.total),
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isBold == false
            ? AppStyles().reg(
                text: label,
                size: 14,
              )
            : AppStyles().semiBold(
                text: label,
                size: 14,
              ),
        isBold == false
            ? AppStyles().reg(
                text: value,
                size: 12,
              )
            : AppStyles().semiBold(
                text: value,
                size: 12,
              ),
      ],
    );
  }
}

class AddressBottomSheet extends StatelessWidget {
  AddressBottomSheet({super.key});
  final List sec = ["Home", "Office"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: Constants.height * 0.8,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                AppStyles().semiBold(text: "Delivery Address", size: 18),
                IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(maxHeight: 10, maxWidth: 0),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppStyles().semiBold(text: "Where should we deliver?", size: 22),
            AppStyles().med(
              color: AppColors.black.withOpacity(0.6),
              text:
                  "Enter address details of the location you want to receive this delivery.",
              size: 16,
              overflow: TextOverflow.visible,
            ),
            const Twoh(),
            AppStyles().med(text: "Tag", size: 16),
            const Oneh(),
            Row(
              children: [
                Row(
                    children: List.generate(sec.length, (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.1),
                    ),
                    child: AppStyles().med(text: sec[index], size: 12),
                  );
                })),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.1),
                  ),
                  child: AppStyles().med(text: "Other", size: 12),
                )
              ],
            ),
            const SizedBox(height: 8),
            AppStyles().med(text: "Name", size: 16),
            CustomTextfieldTwo(
                hintText: "Name", controller: TextEditingController()),
            const SizedBox(height: 8),
            AppStyles().med(text: "Phone Number", size: 16),
            CustomTextfieldTwo(
                hintText: "Phone Number", controller: TextEditingController()),
            const SizedBox(height: 8),
            AppStyles().med(text: "Address Line 1", size: 16),
            CustomTextfieldTwo(
                hintText: "Address Line 1",
                maxLines: 3,
                controller: TextEditingController()),
            const SizedBox(height: 8),
            AppStyles().med(text: "Address Line 2", size: 16),
            CustomTextfieldTwo(
                maxLines: 3,
                hintText: "Address Line 2",
                controller: TextEditingController()),
            const SizedBox(height: 8),
            AppStyles().med(text: "Pin Code", size: 16),
            CustomTextfieldTwo(
                maxLength: 6,
                hintText: "Pin Code",
                controller: TextEditingController()),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles().med(text: "State", size: 16),
                    CustomTextfieldTwo(
                        hintText: "State", controller: TextEditingController()),
                  ],
                )),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles().med(text: "City", size: 16),
                    CustomTextfieldTwo(
                        hintText: "City", controller: TextEditingController()),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 8),
            AppStyles().med(text: "Land Mark", size: 16),
            CustomTextfieldTwo(
                maxLines: 3,
                hintText: "Land Mark",
                controller: TextEditingController()),
            const SizedBox(height: 16),
            AppButton(
              onTap: () {
                Get.to(() => const OrderPlaced());
              },
              text: "Continue",
              iconData: SizedBox(),
            ),
            const Twoh(),
          ],
        ),
      ),
    );
  }
}
