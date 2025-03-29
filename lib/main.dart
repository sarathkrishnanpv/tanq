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
          home: const MainScreen(),
         );
      },
    );
  }
}
