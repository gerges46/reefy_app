
import 'package:flutter/material.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/features/auth/views/login_view.dart';
import 'package:reefy/features/auth/views/register_view.dart';
import 'package:reefy/features/home/views/home_view.dart';
import 'package:reefy/features/onbarding/views/onboarding_view.dart';
import 'package:reefy/features/splash/views/splash_view.dart';

class Routes{
  static const String splashRoute="/";
  static const String loginRoute="/login";
  static const String onBoarding="/onboarding";
  static const String registerRoute="/register";
  static const String forgetPasswordRoute="/forgetPassword";
  static const String mainRoute="/main";
  static const String storeDetailsRoute="/storeDetails";
  static const String onBoardingRoute="/onBoarding";
  static const String homeRoute="/home";
 
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>const SplashView());
     case Routes.onBoardingRoute:
     return MaterialPageRoute(builder: (_)=>const OnboardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.registerRoute:


      
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.homeRoute:


      
        return MaterialPageRoute(builder: (_)=>const HomeView());
      // case Routes.mainRoute:
      //   return MaterialPageRoute(builder: (_)=>const MainView());
 
 
      default:
        return unDefinedRoute();
    }

  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body:  const Center(child:  Text(AppStrings.noRouteFound)),
    ));
  }
}