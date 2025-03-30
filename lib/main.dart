import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanq.driver.app/screens/main_screen.dart';
import 'package:tanq.driver.app/screens/settings_screen/profile_binding.dart';
import 'package:tanq.driver.app/screens/settings_screen/profile_screen.dart';
import 'package:tanq.driver.app/screens/ride_details/new_ride_details_screen.dart';
import 'package:tanq.driver.app/screens/ride_details/new_ride_details_binding.dart';
import 'package:tanq.driver.app/screens/ride_details/accepted_ride_screen.dart';
import 'package:tanq.driver.app/screens/ride_details/accepted_ride_binding.dart';
import 'package:tanq.driver.app/screens/questionnaire/personal_info_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/vehicle_info_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/drivers_license_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/rc_book_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pcc_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pollution_certificate_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/insurance_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/permit_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/aadhar_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pan_screen.dart';
import 'package:tanq.driver.app/bindings/main_binding.dart';
import 'package:tanq.driver.app/screens/splash/splash_screen.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     Constants.width = MediaQuery.sizeOf(context).width;
    Constants.height = MediaQuery.sizeOf(context).height;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Tanq Driver',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2196F3),
              primary: const Color(0xFF2196F3),
              secondary: const Color(0xFF03A9F4),
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFfafafa),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2196F3),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          initialBinding: MainBinding(),
          getPages: [
            GetPage(
              name: '/',
              page: () => const SplashScreen(),
            ),
            GetPage(
              name: '/questionnaire/personal',
              page: () => PersonalInfoScreen(),
              binding: QuestionnaireBinding(),
            ),
            GetPage(
              name: '/questionnaire/vehicle',
              page: () => VehicleInfoScreen(),
            ),
            GetPage(
              name: '/questionnaire/license',
              page: () => DriversLicenseScreen(),
            ),
            GetPage(
              name: '/questionnaire/rc_book',
              page: () => RCBookScreen(),
            ),
            GetPage(
              name: '/questionnaire/pcc',
              page: () => PCCScreen(),
            ),
            GetPage(
              name: '/questionnaire/pollution',
              page: () => PollutionCertificateScreen(),
            ),
            GetPage(
              name: '/questionnaire/insurance',
              page: () => InsuranceScreen(),
            ),
            GetPage(
              name: '/questionnaire/permit',
              page: () => PermitScreen(),
            ),
            GetPage(
              name: '/questionnaire/aadhar',
              page: () => AadharScreen(),
            ),
            GetPage(
              name: '/questionnaire/pan',
              page: () => PANScreen(),
            ),
          ],
          home: const SplashScreen(),
         );
      },
    );
  }
}
