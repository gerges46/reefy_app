import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/home/doctor/views/doctor_home_view.dart';
import 'package:checkin/features/home/views/farmer_home_view.dart';
import 'package:checkin/features/layout/view_model/cubit/layout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/user/views/user_home_view.dart';
import '../../../prices/price_view.dart';
import '../../../profile/views/profile_view.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final AuthCubit authCubit;
  
  LayoutCubit(this.authCubit) : super(LayoutInitial());
  
  int currentNavBarIndex = 0; // استخدم متغير واحد فقط
 
  void changeNavBar(int index) {
    currentNavBarIndex = index;
    emit(LayoutChangeState());
  }

  List<Widget> get pages {
    if (authCubit.selectedRole == UserRole.farmer) {
      return [
        FarmerHomeView(),
     //   FarmerToolsPage(),
        PriceView(),
        ProfileView(),
        ProfileView(),
      ];
    } else if (authCubit.selectedRole == UserRole.doctor) {
      return [
        DoctorHomeView(),
     //   DoctorAppointmentsPage(),
        PriceView(),
        ProfileView(),
        ProfileView(),
      ];
    } else {
      return [
        UserHomeView(),
        PriceView(),
        ProfileView(),
        ProfileView(),
      ];
    }
  }
  
  List<BottomNavigationBarItem> get navItems {
    if (authCubit.selectedRole == UserRole.farmer) {
      return [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: "أدوات المزرعة"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "الأسعار"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "الملف"),
      ];
    } else if (authCubit.selectedRole == UserRole.doctor) {
      return [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "المواعيد"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "الأسعار"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "الملف"),
      ];
    } else {
      return [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "الأسعار"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "الملف"),
      ];
    }
  }
  

}