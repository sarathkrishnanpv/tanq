import 'package:adaptive_spacing/adaptive_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// Temporarily commenting out Google Maps import
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/ride_details/accepted_ride_screen.dart';
import 'package:tanq.driver.app/screens/ride_details/new_ride_details_screen.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/screens/home_screen/home_controller.dart';
import 'package:tanq.driver.app/screens/settings_screen/profile_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanq.driver.app/utils/bottom_sheet_utils.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Add a global key to access the scaffold for opening drawer
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(HomeController());
    
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildNotificationDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with profile and status
            _buildTopBar(controller),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Promo banner
                    AutoScrollCarousel(),
                    
                    // Earnings card
                    _buildEarningsCard(controller),
                    
                    // Ride request card
                    Obx(() => controller.isRideRequested.value
                        ? _buildRideRequestCard(controller)
                        : const SizedBox.shrink()),
                    
                    // Recent rides header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Ride',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Recent rides list
                    _buildRecentRidesList(controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => controller.isOnline.value && 
                                    !controller.isRideRequested.value && 
                                    !controller.isRideAccepted.value && 
                                    !controller.isRideInProgress.value
          ? FloatingActionButton(
              onPressed: () => controller.simulateRideRequest(),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.local_taxi, size: 24),
            )
          : const SizedBox.shrink()),
    );
  }
  
  // Create the notification drawer
  Widget _buildNotificationDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      width: 300.w,
      child: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.images.icons.noNotification.path),
            SizedBox(height: 16.h),
           
          ],
        ),
      ),
    );
  }
  
  Widget _buildTopBar(HomeController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile picture
          GestureDetector(
            onTap: () => Get.to(() => const ProfileScreen()),
            child: Hero(
              tag: 'profile-image',
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: const Color(0xFFFFB6C1),
                      child: ClipOval(
                        child: Image.asset(
                          Assets.images.normal.user.path,
                          width: 40.r,
                          height: 40.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Empty positioned widget to match profile screen structure
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SizedBox(width: 12.r, height: 12.r),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Online status toggle with improved spacing
          Obx(() => Container(
            width: 160.w,
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: controller.isOnline.value ? const Color.fromARGB(255, 65, 201, 65) : const Color.fromARGB(255, 255, 84, 84),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Stack(
              children: [
                // Animated white container
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: controller.isOnline.value ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    width: 100.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.isOnline.value 
                      ? [
                          // When online: car icon + "Online" text
                          Transform.scale(
                            scale:2,
                            child: Image.asset(
                              Assets.images.icons.carIcon.path,
                              width: 20,
                              height: 20,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.directions_car,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          const Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]
                      : [
                          // When offline: "Offline" text + remove icon
                           Container(
                            width: 20.h,
                            height: 20.h,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ), SizedBox(width: 10.w),
                          const Text(
                            'Offline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                         
                         
                        ],
                    ),
                  ),
                ),
                
                // Only show car icon outside white box when offline
                if (!controller.isOnline.value)
                  InkWell(
                    onTap: () => controller.toggleOnlineStatus(),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Transform.scale(
                         scale:2,
                          child: Image.asset(
                           Assets.images.icons.carIcon.path,
                            width: 20,
                            height: 20,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.directions_car,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Only show minus button outside white box when online
                if (controller.isOnline.value)
                  InkWell(
                    onTap: () => controller.toggleOnlineStatus(),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          decoration:  BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Touchable area for entire toggle
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.toggleOnlineStatus(),
                      borderRadius: BorderRadius.circular(8.r),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          )),
          
          // Menu button - Updated to open the drawer
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: SvgPicture.asset(
              Assets.images.icons.sideMenu,
              width: 24,
              height: 24,
            ), 
          ),
        ],
      ),
    );
  }
  
  Widget _buildEarningsCard(HomeController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, ),
      padding: EdgeInsets.all(16.r),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Rupee symbol (smaller and grey, positioned at the top)
                  
                  // Amount value
                  Text(
                    "₹ ${controller.todayEarnings.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
              TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Transaction',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.darkBlue),),
                    SizedBox(width: 4), // Optional spacing between text and icon
                    Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const Text(
            'Total earnings - today',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRideRequestCard(HomeController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
 Image.asset(
                      Assets.images.icons.suvPng.path,
                      width: 40,
                      height: 40,
                    ),                    SizedBox(width: 8.w),
                    const Text(
                      'New Ride request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.images.icons.timeSvg,width: 14,height: 14,),
                    SizedBox(width: 4.w),
                    const Text(
                      '60 Sec',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Pickup location
          Container(
            padding: EdgeInsets.symmetric(horizontal:  10.w,vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w,),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Column(
              children: [
               
          // Pickup location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_downward,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kovalam Beach",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Pickup location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 16.w),
              Container(
                height: 40.h,
                width: 2,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Container(
                        height: 2,
                        width: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          
          // Dropoff location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: const BoxDecoration(
                  color: AppColors.darkBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kazhakkoottam",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Drop-off location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
              ],
            ),
          ),
          
          
          
          // Action buttons
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => const NewRideDetailsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    child: const Text(
                      'Trip Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => const AcceptedRideScreen()));}
                   , style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    child: const Text(
                      'Accept ride',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final reason = await BottomSheetUtils.showRejectionReasonSheet();
                      if (reason != null) {
                        controller.cancelRide(reason: reason);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
  
  Widget _buildRecentRidesList(HomeController controller) {
    return Obx(() {
      if (controller.recentRides.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.directions_car_outlined,
                  size: 48,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 8.h),
                Text(
                  'No recent rides',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      
      // Show only the first ride
      final ride = controller.recentRides.first;
      return _buildRecentRideItem(ride);
    });
  }
  
  Widget _buildRecentRideItem(Map<String, dynamic> ride) {
    final currencyFormat = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 2,
      locale: 'en_IN',
    );
    
    // Format date for display
    final dateFormat = DateFormat('hh:mm a, dd MMM yyyy');
    final formattedDate = dateFormat.format(ride['date'] as DateTime);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car icon and ride ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Car icon
              
              
              // Ride ID and status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
  Image.asset(
                      Assets.images.icons.suvPng.path,
                      width: 40,
                      height: 40,
                    ),                 Text(
                      'ID: ${ride['id']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Completed badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4.w),
                        const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0Xff008000)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Details button
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'More Details',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
             
            ],
          ),
          SizedBox(height: 16.h),
          
          // Pickup location
          Container(
           padding: EdgeInsets.symmetric(horizontal:  10.w,vertical: 10.h),
          
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_downward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride['pickupLocation'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pickup location',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                  Row(
            children: [
              SizedBox(width: 16.w),
              Container(
                height: 40.h,
                width: 2,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Container(
                        height: 2,
                        width: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          
          // Dropoff location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: const BoxDecoration(
                  color: AppColors.darkBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ride['dropoffLocation'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Drop-off location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
              ],
            ),
          ),
        
          SizedBox(height: 16.h),
          
          // Date and payment
          Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Date and Time:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,                children: [
                  const Text(
                    'Ride Payment :',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    currencyFormat.format(ride['fare']),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:Color(0Xff008000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Create a new stateful widget for the carousel with auto-scrolling
class AutoScrollCarousel extends StatefulWidget {
  const AutoScrollCarousel({Key? key}) : super(key: key);

  @override
  State<AutoScrollCarousel> createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends State<AutoScrollCarousel> {
  final PageController pageController = PageController(initialPage: 0);
  Timer? timer;
  
  @override
  void initState() {
    super.initState();
    
    // Set up the timer for auto-scrolling in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (pageController.hasClients) {
          final nextPage = ((pageController.page?.round() ?? 0) + 1) % 3;
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }
  
  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250.h,
          child: PageView.builder(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            onPageChanged: (index) {
              controller.currentCarouselIndex.value = index;
            },
            itemBuilder: (context, index) {
              // Choose different banner images for each slide
              String imageUrl;
              if (index == 0) {
                imageUrl = 'https://t4.ftcdn.net/jpg/03/08/44/53/360_F_308445331_ZZinysRse5xOZacNTnoQqG24TAy7ftZ5.jpg';  // Replace with actual URL
              } else if (index == 1) {
                imageUrl = 'https://img.freepik.com/free-vector/taxi-app-concept-illustration_52683-36028.jpg?uid=R192435103&ga=GA1.1.1727091075.1723610612&semt=ais_keywords_boost';  // Replace with actual URL
              } else {
                imageUrl = 'https://img.freepik.com/free-photo/black-yellow-sign-taxi-night-placed-top-car_181624-17433.jpg?uid=R192435103&ga=GA1.1.1727091075.1723610612&semt=ais_keywords_boost';  // Replace with actual URL
              }
              
              return Container(
                width: double.infinity,
                height: 260.h,
                child: Stack(
                  children: [
                    // Background image - full width and height
                    Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    // Gradient overlay for better text visibility
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: const Text(
                              '25% off on selected\nautos rides ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Add smooth page indicator below the PageView
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            spacing: 8,
            radius: 5,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 1.5,
            dotColor: Colors.grey.shade300,
            activeDotColor: Colors.black,
          ),
          onDotClicked: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2;

    const dashWidth = 4;
    const dashSpace = 4;
    double startY = 0;
    final double endY = size.height;

    while (startY < endY) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
