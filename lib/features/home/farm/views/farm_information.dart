// import 'package:checkin/core/utils/constants/color_manager.dart';
// import 'package:checkin/features/home/view_model/cubit/home_cubit.dart';
// import 'package:checkin/features/home/view_model/cubit/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/utils/constants/assets_manager.dart';
// import '../../../core/utils/constants/values_manager.dart';
// import '../../../shared/custom_button.dart';
// import '../../auth/views/widgets/custom_textform_field.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/utils/constants/assets_manager.dart';
// import '../../../core/utils/constants/color_manager.dart';
// import '../../../core/utils/constants/values_manager.dart';
// import '../view_model/cubit/home_cubit.dart';
// import '../view_model/cubit/home_state.dart';

// class FarmInformationView extends StatelessWidget {
//   const FarmInformationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..fetchFarms(), // Fetch farms when the screen is built
//       child: BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is FarmFailureState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is FetchFarmLoadingState) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (state is FetchFarmSuccessState) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("إدارة مزرعتي", style: TextStyle(fontSize: 20.sp)),
//                 backgroundColor: Colors.white,
//                 elevation: 0,
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.black),
//                   onPressed: () {},
//                 ),
//               ),
//               body: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(AppSize.s24.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             ImageAssets.farmImage,
//                             width: double.infinity,
//                             height: 200.h,
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(height: AppSize.s10.h),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                           child: FarmCard(farmName: state.farms[index].name),
//                         );
//                       },
//                       childCount: state.farms.length, // Use length of the farm list
//                     ),
//                   ),
//                 ],
//               ),
//               floatingActionButton: FloatingActionButton.extended(
//                 onPressed: () {
//                   // Add farm action
//                 },
//                 label: Text("إضافة مزرعة", style: TextStyle(fontSize: 16.sp)),
//                 icon: Icon(Icons.add),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }

//           return Center(child: Text('No Farm available'));
//         },
//       ),
//     );
//   }
// }

// class FarmCard extends StatelessWidget {
//   final String farmName;

//   const FarmCard({super.key, required this.farmName});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.w)),
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               farmName,
//               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add section action
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorManager.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6.w),
//                 ),
//                 minimumSize: Size(140.w, 40.h),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.add, color: Colors.white),
//                   SizedBox(width: 4.w),
//                   Text(
//                     "إضافة عنبر",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/utils/constants/assets_manager.dart';
// import '../../../core/utils/constants/color_manager.dart';
// import '../../../core/utils/constants/values_manager.dart';
// import '../view_model/cubit/home_cubit.dart';
// import '../view_model/cubit/home_state.dart';

// class FarmInformationView extends StatelessWidget {
//   const FarmInformationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..fetchFarms(),
//       child: BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is FarmFailureState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if ( state is FetchFarmLoadingState) {
//             return Scaffold(
//               backgroundColor: Colors.white,
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           if (state is FetchFarmSuccessState) {
//             if (state.farms.isEmpty) {
//               return Scaffold(
//                 appBar: AppBar(
//                   title: Text("إدارة مزرعتي", style: TextStyle(fontSize: 20.sp)),
//                   backgroundColor: Colors.white,
//                   elevation: 0,
//                   leading: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.black),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//                 body: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.agriculture, size: 60.w, color: Colors.grey),
//                       SizedBox(height: 16.h),
//                       Text(
//                         'لا توجد مزارع مسجلة',
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'اضغط على زر + لإضافة مزرعة جديدة',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 floatingActionButton: FloatingActionButton.extended(
//                   onPressed: () {
//                     // Add farm action
//                   },
//                   label: Text("إضافة مزرعة", style: TextStyle(fontSize: 16.sp)),
//                   icon: Icon(Icons.add),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             }

//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("إدارة مزرعتي", style: TextStyle(fontSize: 20.sp)),
//                 backgroundColor: Colors.white,
//                 elevation: 0,
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.black),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//               body: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(AppSize.s24.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             ImageAssets.farmImage,
//                             width: double.infinity,
//                             height: 200.h,
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(height: AppSize.s10.h),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                           child: FarmCard(farmName: state.farms[index].name),
//                         );
//                       },
//                       childCount: state.farms.length,
//                     ),
//                   ),
//                 ],
//               ),
//               floatingActionButton: FloatingActionButton.extended(
//                 onPressed: () {
//                   // Add farm action
//                 },
//                 label: Text("إضافة مزرعة", style: TextStyle(fontSize: 16.sp)),
//                 icon: Icon(Icons.add),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }

//           if (state is FarmFailureState) {
//             return Scaffold(
//               backgroundColor: Colors.white,
//               body: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.error_outline, size: 50.w, color: Colors.red),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'حدث خطأ في تحميل البيانات',
//                       style: TextStyle(fontSize: 18.sp),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       state.errorMessage,
//                       style: TextStyle(fontSize: 14.sp),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 16.h),
//                     ElevatedButton(
//                       onPressed: () => context.read<HomeCubit>().fetchFarms(),
//                       child: Text('إعادة المحاولة'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           return Scaffold(
//             backgroundColor: Colors.white,
//             body: Center(
//               child: Text(
//                 'حالة غير متوقعة',
//                 style: TextStyle(fontSize: 18.sp),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class FarmCard extends StatelessWidget {
//   final String farmName;

//   const FarmCard({super.key, required this.farmName});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.w)),
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               farmName,
//               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add section action
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorManager.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6.w),
//                 ),
//                 minimumSize: Size(140.w, 40.h),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.add, color: Colors.white),
//                   SizedBox(width: 4.w),
//                   Text(
//                     "إضافة عنبر",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constants/app_router.dart';
import '../../../../core/utils/constants/assets_manager.dart';
import '../../../../core/utils/constants/color_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../shared/server_locator.dart';
import '../../view_model/cubit/home_cubit.dart';
import '../../view_model/cubit/home_state.dart';

class FarmInformationView extends StatelessWidget {
  const FarmInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..fetchFarms(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is FarmFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchFarmLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is FetchFarmSuccessState) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                  leading: Padding(
  padding: EdgeInsets.symmetric(horizontal: AppSize.s12.w),
  child: Container(
    width: 50.w, // عرض مناسب للزر
    height: 36.h, // ارتفاع أقل ليكون أكثر تناسقًا
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSize.s8.r),
      border: Border.all(
        color: ColorManager.sideFillColor,
        width: 1.5.w,
      ),
    ),
    child: Center( // لضمان أن الأيقونة في المنتصف تمامًا
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 16.w, // حجم أيقونة مناسب
            color: Colors.black,
          ),
        ),
        padding: EdgeInsets.zero, // إزالة أي مساحات زائدة
        constraints: BoxConstraints(), // عدم إضافة أي قيود إضافية
      ),
    ),
  ),
),

                    title: Text(
                      "إدارة مزرعتي",
                      style: TextStyle(fontSize: 20.sp, color: Colors.black),
                    ),
                    // actions: [
                    //   IconButton(
                    //     icon: Icon(Icons.refresh, color: Colors.black),
                    //     onPressed: () {
                    //       context.read<HomeCubit>().fetchFarms();
                    //     },
                    //   ),
                    // ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSize.s24.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: Image.asset(
                          ImageAssets.farmImage,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  state.farms.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: _buildEmptyState(),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 16.w,
                                ),
                                child: FarmCard(farmName: state.farms[index].farmName),
                              );
                            },
                            childCount: state.farms.length,
                          ),
                        ),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.barnRoute);
                },
                label: Text("إضافة مزرعة", style: TextStyle(fontSize: 16.sp)),
                icon: const Icon(Icons.add),
                backgroundColor: Colors.green,
              ),
            );
          }
          return const Scaffold(body: Center(child: Text('No Farm available')));
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.agriculture, size: 60.w, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            'لا توجد مزارع مسجلة',
            style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 8.h),
          Text(
            'اضغط على زر + لإضافة مزرعة جديدة',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

class FarmCard extends StatelessWidget {
  final String farmName;

  const FarmCard({super.key, required this.farmName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.w)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              farmName,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.w),
                ),
                minimumSize: Size(140.w, 40.h),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 4.w),
                  Text(
                    "إضافة عنبر",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

