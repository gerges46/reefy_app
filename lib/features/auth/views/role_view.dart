import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/assets_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants/app_router.dart';
import 'widgets/custom_card.dart';

class RoleView extends StatelessWidget {
  const RoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final authCubit = AuthCubit.getCubit(context);

            return Column(
              children: [
                SizedBox(height: AppSize.s150.h),
                OptionCard(
                  picture: ImageAssets.farmer,
                  text: AppStrings.farmer,
                  isSelected: authCubit.selectedRole == UserRole.farmer,
                  onTap: () {
                    authCubit.selectRole(UserRole.farmer);
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                ),
                OptionCard(
                  picture: ImageAssets.doctor,
                  text: AppStrings.doctor,
                  isSelected: authCubit.selectedRole == UserRole.doctor,
                  onTap: () {
                    authCubit.selectRole(UserRole.doctor);
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                ),
                OptionCard(
                  picture: ImageAssets.user,
                  text: AppStrings.user,
                  isSelected: authCubit.selectedRole == UserRole.user,
                  onTap: () {
                    authCubit.selectRole(UserRole.user);
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
