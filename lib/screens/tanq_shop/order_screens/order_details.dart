import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_images.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/dotted_line.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});
  final List statuses = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Oneh(),
            _buildDeliveredBanner(),
            const Oneh(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: MySeparator(color: Colors.grey),
            ),
            const Threeh(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildProductSection(),
            ),
            const Twoh(),
            _buildOrderStatus(),
            const Twoh(),
            _buildDeliveryDetails(),
            const Twoh(),
            _buildOrderSummary(),
            const Fiveh(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveredBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles().semiBold(text: "Orders Details", size: 20),
                AppStyles().med(
                    text: "Your order was delivered on 19 Nov 2023",
                    size: 12,
                    overflow: TextOverflow.visible,
                    color: AppColors.green),
              ],
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: const BoxDecoration(
                color: AppColors.green,
              ),
              child: AppStyles().semiBold(
                text: "Delivered",
                size: 14,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppStyles().med(text: "PRODUCTS", size: 16),
            AppStyles().reg(text: "See all", size: 14),
          ],
        ),
        const Twoh(),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.grey,
              ),
              child: Center(
                child: Image.asset(
                  Assets.images.normal.iphone.path,
                  width: Constants.width * 0.3,
                  height: Constants.height * 0.1,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Threew(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles()
                    .semiBold(text: "iPhone 12 Blur Titanium +3 ", size: 14),
                AppStyles().med(text: "69,000", size: 14, height: 2),
                AppStyles().med(
                    text: "Total Amount",
                    size: 14,
                    color: AppColors.black.withOpacity(0.4)),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOrderStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppStyles().med(text: "ORDER STATUS", size: 16)),
        const Twoh(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.6)),
          child: Column(
            children: [
              _orderDetailReuse(
                  title: "Order Confirmed",
                  date: "Tue, 12 Nov 2023",
                  done: true),
              _orderDetailReuse(
                  title: "Packed", date: "Fri, 15 Nov 2023", done: true),
              _orderDetailReuse(
                  title: "On its way", date: "Tue, 18 Nov 2023", done: true),
              _orderDetailReuse(
                  title: "Out for delivery",
                  date: "Tue, 20 Nov 2023",
                  done: true),
              _orderDetailReuse(
                  title: "Delivered", date: "Tue, 22 Nov 2023", done: false),
            ],
          ),
        ),
      ],
    );
  }

  Row _orderDetailReuse({
    required String title,
    required String date,
    required bool done,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: AppColors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: const Icon(Icons.check, color: Colors.black, size: 18),
            ),
            if (done)
              Container(
                width: 2,
                height: 30,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles().med(text: title, size: 15),
            AppStyles().reg(text: date, size: 12),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppStyles().med(text: "DELIVERED TO", size: 16),
        ),
        const Oneh(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles().semiBold(text: "Anandhu S Saran", size: 14),
              AppStyles().reg(
                overflow: TextOverflow.visible,
                text:
                    "New Scheme Rd, Mahalingapuram, Pollachi, Tamil Nadu, 642002, India",
                size: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppStyles().med(text: "ORDER SUMMARY", size: 16),
              AppStyles().med(
                text: "View Receipt",
                size: 14,
                color: AppColors.blue,
              ),
            ],
          ),
        ),
        const Oneh(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _summaryTile("Cart Subtotal - ", "₹69,190"),
              _summaryTile("Discount - ", "₹0.00"),
              _summaryTile("Cart Subtotal -", "₹69,190"),
              _summaryTile("Discount on every products -", "₹0.00"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryTile(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppStyles().reg(text: title, size: 14),
          AppStyles().med(text: amount, size: 14),
        ],
      ),
    );
  }
}
