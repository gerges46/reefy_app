
import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/assets_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants/app_router.dart';
import 'widgets/custom_card.dart';

class RoleView extends StatelessWidget {
  const RoleView({super.key});

  Future<void> _handleRoleSelection(BuildContext context, UserRole role) async {
    final authCubit = AuthCubit.getCubit(context);
    authCubit.selectRole(role);

    // حفظ الدور في الكاش
    await CacheNetwork.insertToCache(
      key: AppConstants.roleIdKey,
      value: role.name, // 'farmer' / 'doctor' / 'user'
    );

    // الانتقال إلى شاشة التسجيل
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, Routes.registerRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final authCubit = AuthCubit.getCubit(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppSize.s150.h),
                OptionCard(
                  picture: ImageAssets.farmer,
                  text: AppStrings.farmer,
                  isSelected: authCubit.selectedRole == UserRole.farmer,
                  onTap: () => _handleRoleSelection(context, UserRole.farmer),
                ),
                OptionCard(
                  picture: ImageAssets.doctor,
                  text: AppStrings.doctor,
                  isSelected: authCubit.selectedRole == UserRole.doctor,
                  onTap: () => _handleRoleSelection(context, UserRole.doctor),
                ),
                OptionCard(
                  picture: ImageAssets.user,
                  text: AppStrings.user,
                  isSelected: authCubit.selectedRole == UserRole.user,
                  onTap: () => _handleRoleSelection(context, UserRole.user),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
