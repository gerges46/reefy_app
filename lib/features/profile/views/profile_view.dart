import 'package:checkin/shared/cubit/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:checkin/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:checkin/features/profile/view_model/cubit/profile_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfileData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                  SizedBox(height: 20.h),
                  Text('الاسم:     ${state.name}'),
                  Text('الإيميل:   ${state.email}'),
                  Text('رقم الهاتف:   ${state.phone}'),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                    ),
                    onPressed: () {
                      // نسيت كلمة المرور
                    },
                    child: const Text('نسيت كلمة المرور'),
                  ),
                  SizedBox(height: 20.h),
                  IconButton(
                    icon: Icon(Icons.light_mode, color: Colors.red),
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
