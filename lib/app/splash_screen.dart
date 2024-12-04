import 'package:customer/controllers/splash_controller.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppThemeData.success400,
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/splash_bg.png"),fit: BoxFit.fill)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/ic_logo.png"),
                  const SizedBox(height: 10,),
                  Text(
                    "Welcome to GroMart".tr,
                    style: TextStyle(color: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey50, fontSize: 28, fontFamily: AppThemeData.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Shop from multiple vendors and enjoy a seamless grocery shopping experience right from your phone.".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
