import 'package:checkin/features/home/doctor/views/widgets/custom_search_bar.dart';
import 'package:checkin/features/home/user/view_model/cubit/user_cubit.dart';
import 'package:checkin/features/home/user/view_model/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../shared/server_locator.dart';
import '../../doctor/views/widgets/search_bar_delegate.dart';
import 'user_farm_details.dart';
import 'widgets/custom_search.dart';
 // Import your details screen for farms.

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(sl())..fetchAllFarms(), // This should be fetchAllFarms() if your method is fetching farms
      child: Scaffold(
        appBar: AppBar(
          title: Text("قائمة المزارع"),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is FetchFarmsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FetchFarmsFailureState) {
              return Center(child: Text('خطأ: ${state.errorMessage}'));
            } else if (state is UserFarmLoadedState) {
              if (state.allFarms.isEmpty) {
                return Column(
                  children: [
                    CustomSearchFieldFarms(
                      controller:
                          BlocProvider.of<UserCubit>(context).searchController,
                      onSearch: () {
                        context.read<UserCubit>().searchFarms(
                          BlocProvider.of<UserCubit>(context)
                              .searchController
                              .text,
                        );
                      },
                      onChanged: (value) {
                        context.read<UserCubit>().searchFarms(value);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'لا يوجد مزارع مطابقين للبحث',
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

              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SearchBarDelegate(
                      CustomSearchField(
                        controller:
                            BlocProvider.of<UserCubit>(context).searchController,
                        onSearch: () {
                          context.read<UserCubit>().searchFarms(
                            BlocProvider.of<UserCubit>(context)
                                .searchController
                                .text,
                          );
                        },
                        onChanged: (value) {
                          context.read<UserCubit>().searchFarms(value);
                        },
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final farms = state.allFarms[index];
                        return Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
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
                                        'assets/images/farm.png', // Update this image path if needed
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            farms.ownerName,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            farms.farmAddress.isNotEmpty
                                                ? farms.farmAddress
                                                : 'العنوان غير متوفر',
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
                                          builder: (_) =>
                                              UserFarmDetailScreen(userFarmModel: farms,), // Updated to match farm details screen
                                        ),
                                      );
                                    },
                                    child: Text('عرض التفاصيل'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.allFarms.length,
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
