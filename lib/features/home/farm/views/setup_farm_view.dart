

import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
import 'package:checkin/features/home/farm/view_model/cubit/farm_managment_cubit.dart';
import 'package:checkin/features/home/farm/view_model/cubit/farm_managment_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_router.dart';
import '../../../../core/utils/constants/assets_manager.dart';
import '../../../../core/utils/constants/color_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../shared/custom_button.dart';
import '../../../../shared/server_locator.dart';
import '../../../../shared/shared_preference_helper.dart';
import '../../../auth/views/widgets/custom_snackbar.dart';
import '../../view_model/cubit/home_cubit.dart';
import '../../view_model/cubit/home_state.dart';
import '../model/farm_info_model.dart';

class SetupFarmView extends StatelessWidget {
  const SetupFarmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FarmManagmentCubit>()..getAllFarms(),
      child: BlocConsumer<FarmManagmentCubit, FarmManagmentState>(
       listener: (context, state) {
  if (state is FarmAdded) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text("تم بنجاح"),
          ],
        ),
        content: Text("تم إضافة المزرعة بنجاح!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
              Navigator.pushNamed(context, Routes.farmInfoRoute);
            },
            child: Text("حسناً"),
          ),
        ],
      ),
    );
  } else if ( state is FarmManagmentError) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text("خطأ"),
          ],
        ),
        content: Text(
       state.message.toString(),
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("إغلاق"),
          ),
        ],
      ),
    );
  }
},

        builder: (context, state) {
          final cubit = context.read<FarmManagmentCubit>();

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: AppPadding.p20.h),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.s50.h),
                        Image.asset(
                          ImageAssets.farmImage,
                          //   height: 150.h,
                        ),
                        SizedBox(height: AppSize.s30.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p10.h,
                          controller: cubit.farmController,
                          hint: "اسم المزرعة",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب إدخال اسم المزرعة';
                            }
                            return null;
                          },
                        ),
                        //SizedBox(height: AppSize.s4.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p10.h,
                          controller: cubit.addressController,
                          hint: "العنوان",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب إدخال العنوان';
                            }
                            return null;
                          },
                        ),
                        //  SizedBox(height: AppSize.s4.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p10.h,
                          controller: cubit.governorateController,
                          hint: "المحافظة",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب إدخال المحافظة';
                            }
                            return null;
                          },
                        ),
                        //SizedBox(height: AppSize.s4.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p10.h,
                          controller: cubit.regionController,
                          hint: "المدينة",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب إدخال المدينة';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSize.s120.h),
                        CustomButton(
                          title: "التالي",
                          color: ColorManager.primary,
                          textColor: Colors.white,
                          onPressed: () async {
                            final userIdString =
                                await CacheNetwork.getStringFromCache(
                                  key: AppConstants.userIdKey,
                                );

                            final userId =
                                int.tryParse(userIdString ?? '0') ?? 0;

                            if (userId == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'حصل خطأ، حاول تسجيل الدخول مرة تانية',
                                  ),
                                ),
                              );
                              return;
                            }
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.createNewFarm(
                                FarmModel(
                                  farmName: cubit.farmController.text,
                                  address: cubit.addressController.text,
                                  governorate: cubit.governorateController.text,
                                  region: cubit.regionController.text,
                                  userId: userId, // هنا حط الـ userId المناسب
                                ),
                              );
                            }
                          },
                          // onPressed: () {
                          //   Navigator.pushNamed(
                          //     context,
                          //     Routes.farmInfoRoute,
                          //   );
                          // },
                        ),
                        SizedBox(height: AppSize.s40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
