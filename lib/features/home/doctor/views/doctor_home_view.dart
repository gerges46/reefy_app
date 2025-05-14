
import 'package:checkin/features/home/doctor/views/doctor_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/server_locator.dart';
import '../view_model/cubit/doctor_cubit.dart';
import '../view_model/cubit/doctor_state.dart';
import 'widgets/custom_search_bar.dart';
import 'widgets/search_bar_delegate.dart';

// class DoctorHomeView extends StatelessWidget {
//   const DoctorHomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => DoctorCubit(sl())..fetchAllDoctors(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("قائمة الأطباء"),

//           backgroundColor: Colors.white,
         
//         ),
//         body: BlocBuilder<DoctorCubit, DoctorState>(
//           builder: (context, state) {
//             if (state is FetchDoctorLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is FetchDoctorFailureState) {
//               return Center(child: Text('خطأ: ${state.errorMessage}'));
//             } else if (state is DoctorLoadedState) {
//               if (state.doctors.isEmpty) {
//                 return Column(
//                   children: [
//                     CustomSearchField(
//                       controller:
//                           BlocProvider.of<DoctorCubit>(
//                             context,
//                           ).searchController,
//                       onSearch: () {
//                         context.read<DoctorCubit>().searchDoctors(
//                           BlocProvider.of<DoctorCubit>(
//                             context,
//                           ).searchController.text,
//                         );
//                       },
//                       onChanged: (value) {
//                         context.read<DoctorCubit>().searchDoctors(value);
//                       },
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           'لا يوجد أطباء مطابقين للبحث',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }

//               return CustomScrollView(
//                 slivers: [
//                   // SliverAppBar(
//                   //   pinned: true,
//                   //   floating: true,
//                   //   backgroundColor: Colors.white,
//                   //   expandedHeight: 90.h,
//                   //   flexibleSpace: FlexibleSpaceBar(
//                   //     background: CustomSearchField(
//                   //       controller:
//                   //           BlocProvider.of<DoctorCubit>(
//                   //             context,
//                   //           ).searchController,
//                   //       onSearch: () {
//                   //         context.read<DoctorCubit>().searchDoctors(
//                   //           BlocProvider.of<DoctorCubit>(
//                   //             context,
//                   //           ).searchController.text,
//                   //         );
//                   //       },
//                   //       onChanged: (value) {
//                   //         context.read<DoctorCubit>().searchDoctors(value);
//                   //       },
//                   //     ),
//                   //   ),
//                   // ),
//                   SliverPersistentHeader(
//                     pinned: true, // This keeps it visible when scrolling
//                     delegate: SearchBarDelegate(
//                       CustomSearchField(
//                         controller:
//                             BlocProvider.of<DoctorCubit>(
//                               context,
//                             ).searchController,
//                         onSearch: () {
//                           context.read<DoctorCubit>().searchDoctors(
//                             BlocProvider.of<DoctorCubit>(
//                               context,
//                             ).searchController.text,
//                           );
//                         },
//                         onChanged: (value) {
//                           context.read<DoctorCubit>().searchDoctors(value);
//                         },
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate((context, index) {
//                       final doctor = state.doctors[index];
//                       return Card(
//                         color: Colors.white,
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 16.w,
//                           vertical: 8.h,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.r),
//                         ),
//                         elevation: 4,
//                         child: Padding(
//                           padding: EdgeInsets.all(16.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 30.r,
//                                     backgroundImage: AssetImage(
//                                       'assets/images/doctor.png',
//                                     ),
//                                   ),
//                                   SizedBox(width: 12.w),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           doctor.userName,
//                                           style: TextStyle(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 4.h),
//                                         Text(
//                                           doctor.address ?? 'العنوان غير متوفر',
//                                           style: TextStyle(
//                                             fontSize: 14.sp,
//                                             color: Colors.grey[700],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 12.h),
//                               Text(
//                                 "التقييم:",
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),
//                               Row(
//                                 children: List.generate(5, (i) {
//                                   return Icon(
//                                     i < 3 ? Icons.star : Icons.star_border,
//                                     color: Colors.amber,
//                                     size: 20.sp,
//                                   );
//                                 }),
//                               ),
//                               SizedBox(height: 12.h),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder:
//                                             (_) => DoctorDetailScreen(doctor),
//                                       ),
//                                     );
//                                   },
//                                   child: Text('عرض التفاصيل'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }, childCount: state.doctors.length),
//                   ),
//                 ],
//               );
//             }

//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
// doctor_home_view.dart


class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorCubit(sl())..fetchAllDoctors(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("قائمة الأطباء"),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is FetchDoctorLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FetchDoctorFailureState) {
              return Center(child: Text('خطأ: ${state.errorMessage}'));
            } else if (state is DoctorLoadedState) {
              if (state.doctors.isEmpty) {
                return Column(
                  children: [
                    CustomSearchField(
                      controller: BlocProvider.of<DoctorCubit>(context)
                          .searchController,
                      onSearch: () {
                        context.read<DoctorCubit>().searchDoctors(
                          BlocProvider.of<DoctorCubit>(context)
                              .searchController.text,
                        );
                      },
                      onChanged: (value) {
                        context.read<DoctorCubit>().searchDoctors(value);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'لا يوجد أطباء مطابقين للبحث',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              // return CustomScrollView(
              //   slivers: [
              //     SliverPersistentHeader(
              //       pinned: true, // This keeps it visible when scrolling
              //       delegate: SearchBarDelegate(
              //         CustomSearchField(
              //           controller: BlocProvider.of<DoctorCubit>(context)
              //               .searchController,
              //           onSearch: () {
              //             context.read<DoctorCubit>().searchDoctors(
              //               BlocProvider.of<DoctorCubit>(context)
              //                   .searchController.text,
              //             );
              //           },
              //           onChanged: (value) {
              //             context.read<DoctorCubit>().searchDoctors(value);
              //           },
              //         ),
              //       ),
              //     ),
              //     SliverList(
              //       delegate: SliverChildBuilderDelegate((context, index) {
              //         final doctor = state.doctors[index];
              //         return Card(
              //           color: Colors.white,
              //           margin: EdgeInsets.symmetric(
              //             horizontal: 16.w,
              //             vertical: 8.h,
              //           ),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20.r),
              //           ),
              //           elevation: 4,
              //           child: Padding(
              //             padding: EdgeInsets.all(16.w),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   children: [
              //                     CircleAvatar(
              //                       radius: 30.r,
              //                       backgroundImage: AssetImage(
              //                         'assets/images/doctor.png',
              //                       ),
              //                     ),
              //                     SizedBox(width: 12.w),
              //                     Expanded(
              //                       child: Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             doctor.userName,
              //                             style: TextStyle(
              //                               fontSize: 18.sp,
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                           SizedBox(height: 4.h),
              //                           Text(
              //                             doctor.address ?? 'العنوان غير متوفر',
              //                             style: TextStyle(
              //                               fontSize: 14.sp,
              //                               color: Colors.grey[700],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: 12.h),
              //                 Text(
              //                   "التقييم:",
              //                   style: TextStyle(
              //                     fontSize: 16.sp,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //                 SizedBox(height: 4.h),
              //                 Row(
              //                   children: List.generate(5, (i) {
              //                     return Icon(
              //                       i < 3 ? Icons.star : Icons.star_border,
              //                       color: Colors.amber,
              //                       size: 20.sp,
              //                     );
              //                   }),
              //                 ),
              //                 SizedBox(height: 12.h),
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: ElevatedButton(
              //                     onPressed: () {
              //                       Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                           builder: (_) => DoctorDetailScreen(doctor),
              //                         ),
              //                       );
              //                     },
              //                     child: Text('عرض التفاصيل'),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       }, childCount: state.doctors.length),
              //     ),
              //   ],
              // );
              return CustomScrollView(
  slivers: [
    SliverPersistentHeader(
      pinned: true,
      delegate: SearchBarDelegate(
        CustomSearchField(
          controller: BlocProvider.of<DoctorCubit>(context).searchController,
          onSearch: () {
            context.read<DoctorCubit>().searchDoctors(
              BlocProvider.of<DoctorCubit>(context).searchController.text,
            );
          },
          onChanged: (value) {
            context.read<DoctorCubit>().searchDoctors(value);
          },
        ),
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final doctor = state.doctors[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: AssetImage(
                            'assets/images/doctor.png',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.userName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                doctor.address ?? 'العنوان غير متوفر',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "التقييم:",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < 3 ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 20.sp,
                        );
                      }),
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorDetailScreen(doctor),
                            ),
                          );
                        },
                        child: Text('عرض التفاصيل'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: state.doctors.length,
      ),
    ),
  ],
);

            }

            return Container();
          },
        ),
      ),
    );
  }
}