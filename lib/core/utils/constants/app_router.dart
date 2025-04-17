import 'package:checkin/features/auth/views/role_view.dart';
import 'package:checkin/features/home/doctor/views/doctor_layout_view.dart';
import 'package:checkin/features/home/views/barn_view.dart';
import 'package:checkin/features/home/doctor/views/doctor_home_view.dart';
import 'package:checkin/features/home/views/farm_information.dart';
import 'package:checkin/features/home/user/views/user_home_view.dart';
import 'package:checkin/features/layout/views/main_layout_view.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/views/forget_password.dart';
import '../../../features/auth/views/login_view.dart';
import '../../../features/auth/views/new_password_view.dart';
import '../../../features/auth/views/otp_view.dart';
import '../../../features/auth/views/register_view.dart';
import '../../../features/home/views/farmer_home_view.dart';
import '../../../features/home/views/setup_farm_view.dart';
import '../../../features/onbarding/views/onboarding_view.dart';
import '../../../features/splash/views/splash_view.dart';
import 'app_strings.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String onBoarding = "/onboarding";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoardingRoute = "/onBoarding";
  static const String homeRoute = "/home";
  static const String otpRoute = "/otp";
  static const String newPasswordRoute = "/newPassword";
  static const String roleRoute = "/role";

  static const String farmSetupRoute = "/farmSetup";
  static const String farmInfoRoute = "/farmInformation";
  static const String barnRoute = "/barn";
    // Routes for different users
  static const String farmerHomeRoute = "/farmerHome";
  static const String doctorHomeRoute = "/doctorHome";
  static const String userHomeRoute = "/userHome";
  static const String layoutRoute = "/layout";
  static const String doctorLayoutRoute = "/doctorLayout";
  
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const FarmerHomeView());

      case Routes.otpRoute:
        return MaterialPageRoute(builder: (_) => const OtpView());

      case Routes.newPasswordRoute:
        return MaterialPageRoute(builder: (_) => const NewPasswordView());
      case Routes.roleRoute:
        return MaterialPageRoute(builder: (_) => const RoleView());
      case Routes.farmerHomeRoute:
        return MaterialPageRoute(builder: (_) => const FarmerHomeView());
      case Routes.farmSetupRoute:
        return MaterialPageRoute(builder: (_) => const SetupFarmView());
      case Routes.farmInfoRoute:
        return MaterialPageRoute(builder: (_) => const FarmInformationView());
      case Routes.barnRoute:
        return MaterialPageRoute(builder: (_) => const BarnView());
      case Routes.userHomeRoute:
        return MaterialPageRoute(builder: (_) => const UserHomeView());
      case Routes.doctorHomeRoute:
        return MaterialPageRoute(builder: (_) => const DoctorHomeView());
      case Routes.layoutRoute:
        return MaterialPageRoute(builder: (_) => const HomeLayoutView ());
      case Routes.doctorLayoutRoute:
        return MaterialPageRoute(builder: (_) => const DoctorLayoutView ());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
            body: const Center(child: Text(AppStrings.noRouteFound)),
          ),
    );
  }
}
