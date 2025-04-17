// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // import '../../view_model/cubit/doctor_cubit.dart';

// // class CustomSearchField extends StatelessWidget {
// //   final TextEditingController controller;
// //   final VoidCallback onSearch;
// //   final ValueChanged<String> onChanged;
// //   const CustomSearchField({
// //     super.key,
// //     required this.controller,
// //     required this.onSearch, required this.onChanged,

// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.all(16),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: TextField(
// //               controller: controller,
// //               textAlign: TextAlign.right,
// //               decoration: InputDecoration(
// //                 hintText: 'ابحث',
// //                 prefixIcon: Icon(Icons.search),
// //                 filled: true,
// //                 fillColor: Colors.white,
// //                 contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                   borderSide: BorderSide(color: Colors.grey.shade300),
// //                 ),
// //               ),
// //               onChanged: (value) {
// //                 context.read<DoctorCubit>().searchDoctors(value);
// //               },
// //             ),
// //           ),
// //           SizedBox(width: 8),
// //           ElevatedButton(
// //             onPressed: onSearch,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //               ),
// //             ),
// //             child: Text('ابحث'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:checkin/core/utils/constants/color_manager.dart';
// import 'package:checkin/core/utils/constants/values_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../view_model/cubit/doctor_cubit.dart';

// class CustomSearchField extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onSearch;
//   final ValueChanged<String> onChanged;

//   const CustomSearchField({
//     super.key,
//     required this.controller,
//     required this.onSearch,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       child: SizedBox(
//         height: AppSize.s44.h,
//         child: TextField(
//           controller: controller,
//           textAlign: TextAlign.right,
//           decoration: InputDecoration(
//             hintText: 'ابحث',
//             hintStyle: TextStyle(fontSize: 14.sp),
//             prefixIcon: Icon(Icons.search, size: 20.sp),
//             suffixIcon: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: onSearch,
//                 child: Container(
//                     height: 20.h,
//                   width: 60.w,
//                   decoration:BoxDecoration(
//                     color: ColorManager.primary,
//                     borderRadius: BorderRadius.circular(AppSize.s8.r)
//                   ),
//                   child:Center(child: Text('ابحث',style: TextStyle(color: Colors.white,fontSize: AppSize.s18,fontWeight: FontWeight.w600),)) ,
//                 ),
//               ),
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppSize.s8.r),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder:  OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppSize.s8.r),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//           ),
//           onChanged: (value) {
//             context.read<DoctorCubit>().searchDoctors(value);
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/doctor_cubit.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final ValueChanged<String> onChanged;

  const CustomSearchField({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h), // ✅ تقليل البادينغ
      child: SizedBox(
       // height: AppSize.s40.h, // ✅ تقليل الارتفاع
         height: AppSize.s80.h,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'ابحث',
            hintStyle: TextStyle(fontSize: 14.sp),
            prefixIcon: Icon(Icons.search, size: 20.sp),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: onSearch,
                child: Container(
                  height: 20.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(AppSize.s8.r),
                  ),
                  child: Center(
                    child: Text(
                      'ابحث',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s8.r),
              borderSide: BorderSide(color: Colors.grey.shade300,
              width: AppSize.s1
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s8.r),
              borderSide: BorderSide(color: Colors.grey.shade300,
                 width: AppSize.s1
              ),
            ),
          ),
          onChanged: (value) {
            context.read<DoctorCubit>().searchDoctors(value);
          },
        ),
      ),
    );
  }
}
