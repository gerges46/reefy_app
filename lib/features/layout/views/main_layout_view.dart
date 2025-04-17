import 'package:checkin/features/layout/view_model/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/view_model/auth_cubit/auth_cubit.dart';
import '../view_model/cubit/layout_state.dart';

class HomeLayoutView extends StatelessWidget {
  const HomeLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final layoutCubit = context.read<LayoutCubit>();

    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_getAppBarTitle(authCubit.selectedRole)),
          ),
       //   body: layoutCubit.pages[layoutCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            // currentIndex: layoutCubit.currentIndex,
            // onTap: layoutCubit.changeIndex,
            // items: layoutCubit.navItems,
  currentIndex: layoutCubit.currentNavBarIndex,
  onTap: layoutCubit.changeNavBar,
  items:layoutCubit.navItems ,

          ),
          body: layoutCubit.pages[layoutCubit.currentNavBarIndex],
        );
      },
    );
  }

  String _getAppBarTitle(UserRole? role) {
    switch (role) {
      case UserRole.farmer: return "لوحة المزارع";
      case UserRole.doctor: return "لوحة الطبيب";
      case UserRole.user: 
      default: return "الصفحة الرئيسية";
    }
  }
}