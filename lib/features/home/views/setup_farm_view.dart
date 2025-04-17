
import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants/app_router.dart';
import '../../../core/utils/constants/assets_manager.dart';
import '../../../core/utils/constants/color_manager.dart';
import '../../../core/utils/constants/values_manager.dart';
import '../../../shared/custom_button.dart';
import '../../auth/views/widgets/custom_snackbar.dart';
import '../view_model/cubit/home_cubit.dart';
import '../view_model/cubit/home_state.dart';

class SetupFarmView extends StatelessWidget {
  const SetupFarmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchFarms(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is FarmSuccessState) {
            CustomSnackBar(
              message: "تم إضافة المزرعة بنجاح",
              isError: false,
            );
            Navigator.pushNamed(context, Routes.farmInfoRoute);
          } else if (state is FarmFailureState) {
            CustomSnackBar(
              message: state.errorMessage,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

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
                          controller: cubit.farmController,
                          hint: "اسم المزرعة",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب إدخال اسم المزرعة';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSize.s120.h),
                        CustomButton(
                          title: "التالي",
                          color: ColorManager.primary,
                          textColor: Colors.white,
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.addFarmer(cubit.farmController.text);
                            }
                          },
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
