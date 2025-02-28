import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reefy/core/utils/constants/app_router.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/assets_manager.dart';
import 'package:reefy/core/utils/constants/color_manager.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';
import 'package:reefy/shared/custom_button.dart';


class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        children: [
        SizedBox(height: AppSize.s110.h),
          Image.asset(ImageAssets.onBoardingLogoPng,width: AppSize.s250.w,height: AppSize.s250.h,),
          const SizedBox(height: AppSize.s20,),
        CustomButton(
          title: AppStrings.start,
          color: Colors.white,
          textColor: ColorManager.darkGray,
          onPressed: () {

            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          },
        ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:reefy/core/utils/constants/app_strings.dart';
// import 'package:reefy/core/utils/constants/assets_manager.dart';
// import 'package:reefy/core/utils/constants/color_manager.dart';
// import 'package:reefy/core/utils/constants/media_query_values.dart';
// import 'package:reefy/core/utils/constants/style_manager.dart';
// import 'package:reefy/core/utils/constants/values_manager.dart';

// class OnboardingView extends StatelessWidget {
//   const OnboardingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.primary,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return _buildContent(
//             context,
//             constraints.maxWidth,
//             constraints.maxHeight,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildContent(BuildContext context, double width, double height) {
//     return Column(
//       children: [
//         SizedBox(height: height * MediaQueryValues.m10), // 10% of screen height
//         Image.asset(
//           ImageAssets.onBoardingLogoPng,
//           width: width * MediaQueryValues.m6, // 60% of screen width
//           height: height * MediaQueryValues.m4, // 30% of screen height
//           fit: BoxFit.contain,
//         ),
//         SizedBox(height: height * MediaQueryValues.m03), // 3% of screen height
//         Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: width * MediaQueryValues.m05,
//           ), // 5% padding
//           child: MaterialButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(
//                 width * MediaQueryValues.m03,
//               ), // Responsive corner radius
//             ),
//             minWidth: width * MediaQueryValues.m09, // 90% of screen width
//             height: height * MediaQueryValues.m07, // 7% of screen height
//             color: Colors.white,
//             onPressed: () {},
//             child: Text(
//               AppStrings.start,
//               style: semiBold(
//                 color: ColorManager.primary,
//                 fontSize: width * MediaQueryValues.m05,
//               ), // Responsive font size
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
