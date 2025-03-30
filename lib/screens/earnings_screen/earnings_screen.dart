import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'earnings_controller.dart';
import 'package:tanq.driver.app/widgets/grid_background.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(EarningsController());
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background gradient
          const GridBackGround(),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Earnings',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main content (white background)
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        // Earnings Card
                        _buildEarningsCard(controller),
                        
                        // Period Selector Tabs
                        _buildPeriodSelector(controller),
                        
                        // Transactions List
                        _buildTransactionsList(controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEarningsCard(EarningsController controller) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Amount with custom styled rupee symbol
              Row(
                children: [
                  // Rupee symbol (smaller and grey, positioned at the top)
                  Text(
                    '₹ ' ,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[600],
                      height: 0.8,
                    ),
                  ),
                  // Amount value with comma formatting
                  Obx(() => Text(
                    '${controller.totalEarnings.value}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 20.h,
              ),
              // Today with down arrow
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(Assets.images.icons.arrowUpAndDown)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Subtitle with blue color for "total earnings"
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'You\'re total earnings of today',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF172E71),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPeriodSelector(EarningsController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // Custom Tabs Implementation
          Expanded(
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: TabBar(
                controller: controller.tabController,
                padding: EdgeInsets.all(4.r),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  SizedBox(
                    height: 35.h,
                    child: const Center(child: Text('Today')),
                  ),
                  SizedBox(
                    height: 35.h,
                    child: const Center(child: Text('Last 7 days')),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Calendar icon
          Container(
            width: 45.h,
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: InkWell(
              onTap: controller.showDatePickerDialog,
              child: Center(
                child: SvgPicture.asset(Assets.images.icons.calendarDark)
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTransactionsList(EarningsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Transaction header
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 12.h),
          child: Obx(() => Text(
            controller.selectedPeriod.value == 0 
                ? 'Transaction - today'
                : controller.selectedPeriod.value == 1 
                    ? 'Transaction - last 7 days'
                    : 'Transaction - ${controller.formattedDate}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
        
        // PageView for swipe gestures
        SizedBox(
          height: 400.h, // Adjust height as needed
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              if (index < 2) { // Only animate tab controller for the first two tabs
                controller.tabController.animateTo(index);
              }
              controller.selectedPeriod.value = index;
            },
            children: [
              // Today's transactions
              _buildTransactionListView(controller, 0),
              // Last 7 days transactions
              _buildTransactionListView(controller, 1),
              // Custom date transactions
              _buildTransactionListView(controller, 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionListView(EarningsController controller, int period) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: controller.transactions.length,
      itemBuilder: (context, index) => _buildTransactionItem(controller.transactions[index]),
    ));
  }
  
  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    return InkWell(
      onTap: () => _showTransactionDetails(Get.context!, transaction),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Profile circle with initials
            Container(
              width: 44.w,
              height: 44.h,
              decoration: const BoxDecoration(
                color: Color(0xFF333333),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  transaction['initials'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Customer details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['customerName'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGray,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        '12 Nov 2024 | 7:30 PM',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 231, 255),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: const Text(
                          'Paid in cash',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color:AppColors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Amount
            Row(
              children: [
                Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    height: 0.8,
                  ),
                ),
                Text(
                  '${transaction['amount']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
         
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  
                  // Payment Details Section
                  const Text(
                    'Payment Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Payment type:', 'Paid in cash', isHighlighted: true),
                          _buildDetailRow('Ride Pay:', '₹ 482.00'),
                      ],
                    ),
                  ),
                
                  SizedBox(height: 24.h),

                  // Ride Details Section
                  const Text(
                    'Ride Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildDetailRow2('Pickup location:', 'Sree Padmanabhaswamy Temple'),
                  _buildDetailRow2('Drop-off location:', 'Museum Junction, Thiruvananthapuram'),
                  _buildDetailRow2('Date and Time:', '12:47 PM, 12 Nov 2024'),
                ],
              ),
            ),
            // Done Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          isHighlighted
            ?  Container(
             
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 231, 255),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Text(
                       value,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color:AppColors.purple,
                        ),
                      ),
                    )
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildDetailRow2(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          isHighlighted
            ?  Container(
             
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 231, 255),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Text(
                       value,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color:AppColors.purple,
                        ),
                      ),
                    )
            : Expanded(
              child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ),
        ],
      ),
    );
  }
} 